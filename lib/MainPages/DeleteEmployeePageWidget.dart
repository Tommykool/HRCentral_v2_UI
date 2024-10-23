import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrcentral_v2_ui/API_Calls/employeeAPI_Calls/EmployeeDTO.dart';
import 'package:hrcentral_v2_ui/API_Calls/employeeAPI_Calls/EmployeeInput.dart';
import 'package:hrcentral_v2_ui/API_Calls/employeeAPI_Calls/employeeAPI.dart';

class DeleteEmployeePageWidget extends StatefulWidget {
  final EmployeeDTO employee;

  const DeleteEmployeePageWidget({required this.employee, super.key});

  @override
  State<DeleteEmployeePageWidget> createState() => _DeleteEmployeePageWidgetState();
}

class _DeleteEmployeePageWidgetState extends State<DeleteEmployeePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final List<TextEditingController> textControllers = List.generate(8, (_) => TextEditingController());
  final _formKey = GlobalKey<FormState>();
  final employeeAPI api = employeeAPI();

  @override
  void initState() {
    super.initState();
    // Populate the text controllers with employee data
    textControllers[0].text = widget.employee.id ?? '';
    textControllers[1].text = widget.employee.firstName ?? '';
    textControllers[2].text = widget.employee.lastName ?? '';
    textControllers[3].text = widget.employee.email ?? '';
    textControllers[4].text = widget.employee.department ?? '';
    textControllers[5].text = widget.employee.jobTitle ?? '';
    textControllers[6].text = widget.employee.phone ?? '';
    textControllers[7].text = widget.employee.address ?? '';
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
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => context.go('/employeesPage'),
          ),
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.person_sharp, color: Colors.white, size: 40),
              SizedBox(width: 9),
              Text('Profile', style: TextStyle(color: Colors.white, fontSize: 24)),
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
                          Text('Employee Profile', style: Theme.of(context).textTheme.titleLarge),
                          const SizedBox(height: 16),
                          ...[
                            'Employee ID',
                            'First Name',
                            'Last Name',
                            'Email',
                            'Department',
                            'Job Position',
                            'Phone',
                            'Home Address'
                          ].asMap().entries.map((entry) => Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: TextFormField(
                              controller: textControllers[entry.key],
                              decoration: InputDecoration(
                                labelText: entry.value,
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                              readOnly: true, // Make all fields read-only
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
                       //  api.deleteEmployee(textControllers[0].text);
                       // context.go('/employeesPage');
                        showDialog(context: context, builder: (BuildContext context){
                          return AlertDialog(
                            title: const Text('Are you sure?'),
                            content: const Text('Do you really want to delete this employee?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); // Close the dialog on cancel
                                },
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Perform the delete action
                                  api.deleteEmployee(textControllers[0].text);
                                  Navigator.of(context).pop(); // Close the dialog after deletion
                                  context.go('/employeesPage'); // Navigate back after deletion
                                },
                                child: const Text('Delete'),
                              ),
                            ],
                          );
                        });
                      },

                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Delete employee'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        // Removed the FloatingActionButton since updates are no longer possible
      ),
    );
  }
}