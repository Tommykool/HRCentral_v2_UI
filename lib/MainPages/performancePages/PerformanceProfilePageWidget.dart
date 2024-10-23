import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrcentral_v2_ui/API_Calls/employeeAPI_Calls/EmployeeDTO.dart';
import 'package:hrcentral_v2_ui/API_Calls/performanceAPI_Calls/PerformanceDTO.dart';
import 'package:hrcentral_v2_ui/API_Calls/performanceAPI_Calls/performanceAPI.dart';

class PerformanceProfilePageWidget extends StatefulWidget {
  final PerformanceDTO performance;
  final EmployeeDTO employee;
  const PerformanceProfilePageWidget({required this.performance, required this.employee,super.key});

  @override
  State<PerformanceProfilePageWidget> createState() => _PerformanceProfilePageWidgetState();
}

class _PerformanceProfilePageWidgetState extends State<PerformanceProfilePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final List<TextEditingController> textControllers = List.generate(7, (_) => TextEditingController());
  final _formKey = GlobalKey<FormState>();
  final PerformanceAPIService api = PerformanceAPIService();

  @override
  void initState() {
    super.initState();
    // Populate the text controllers with performance data
    textControllers[0].text = widget.performance.id.toString();
    textControllers[1].text = widget.performance.employeeId ?? '';
    textControllers[2].text = widget.performance.reviewPeriod ?? '';
    textControllers[3].text = widget.performance.reviewScore?.toString() ?? '';
    textControllers[4].text = widget.performance.feedback ?? '';
    textControllers[5].text = widget.performance.reviewerName ?? '';
    textControllers[6].text = widget.performance.createdAt.toString();
  }

  @override
  void dispose() {
    for (var controller in textControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.assessment, color: Colors.white, size: 40),
              SizedBox(width: 9),
              Text('Performance Profile', style: TextStyle(color: Colors.white, fontSize: 24)),
            ],
          ),
          centerTitle: true,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Theme.of(context).primaryColor, Theme.of(context).primaryColorLight],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text('Performance Details', style: Theme.of(context).textTheme.titleLarge),
                          const SizedBox(height: 16),
                          ...[
                            'Performance ID',
                            'Employee ID',
                            'Review Period',
                            'Review Score',
                            'Feedback',
                            'Reviewer Name',
                            'Created At'
                          ].asMap().entries.map((entry) => Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: TextFormField(
                              controller: textControllers[entry.key],
                              decoration: InputDecoration(
                                labelText: entry.value,
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                              readOnly:true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter ${entry.value}';
                                }
                                return null;
                              },
                            ),
                          )),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 60),
                    child: ElevatedButton(
                      onPressed: () {
                        context.go('/employeePerformances',extra: widget.employee);
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Back'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // Show an alert dialog with delete and cancel options
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Delete Performance'),
                  content: const Text('Are you sure you want to delete this performance?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog without doing anything
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        // Call delete API here
                        api.deletePerformance(widget.performance.id).then((_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Performance deleted successfully')),
                          );
                          context.go('/employeePerformances',extra: widget.employee); // Navigate to another page after delete
                        }).catchError((error) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error deleting performance: $error')),
                          );
                        });
                        Navigator.of(context).pop(); // Close the dialog after deletion
                      },
                      child: const Text('Delete', style: TextStyle(color: Colors.red)),
                    ),
                  ],
                );
              },
            );
          },
          icon: const Icon(Icons.delete),
          label: const Text('Delete'),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      ),
    );
  }
}
