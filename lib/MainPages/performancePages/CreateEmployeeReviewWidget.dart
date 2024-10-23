import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrcentral_v2_ui/API_Calls/employeeAPI_Calls/EmployeeDTO.dart';
import 'package:hrcentral_v2_ui/API_Calls/performanceAPI_Calls/PerformanceInput.dart';
import 'package:hrcentral_v2_ui/API_Calls/performanceAPI_Calls/performanceAPI.dart';


class CreateEmployeeReviewWidget extends StatefulWidget {
  final EmployeeDTO employee;

  const CreateEmployeeReviewWidget({required this.employee,super.key});

  @override
  State<CreateEmployeeReviewWidget> createState() => _CreateEmployeeReviewWidgetState();
}

class _CreateEmployeeReviewWidgetState extends State<CreateEmployeeReviewWidget> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _employeeIdController;
  late final TextEditingController _employeeNameController;
  late final TextEditingController _jobTitleController;
  final TextEditingController _reviewPeriodController = TextEditingController();
  final TextEditingController _reviewScoreController = TextEditingController();
  final TextEditingController _feedbackController = TextEditingController();
  final TextEditingController _reviewerNameController = TextEditingController();
  final PerformanceAPIService api = PerformanceAPIService();

  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _employeeIdController = TextEditingController(text: widget.employee.id);
    _employeeNameController = TextEditingController(text: "${widget.employee.firstName} ${widget.employee.lastName}");
    _jobTitleController = TextEditingController(text: widget.employee.jobTitle);
    _reviewPeriodController.addListener(_validateForm);
    _reviewScoreController.addListener(_validateForm);
    _feedbackController.addListener(_validateForm);
    _reviewerNameController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _employeeIdController.dispose();
    _employeeNameController.dispose();
    _jobTitleController.dispose();
    _reviewPeriodController.dispose();
    _reviewScoreController.dispose();
    _feedbackController.dispose();
    _reviewerNameController.dispose();
    super.dispose();
  }

  void _validateForm() {
    setState(() {
      _isFormValid = _reviewPeriodController.text.isNotEmpty &&
          _reviewScoreController.text.isNotEmpty &&
          _feedbackController.text.isNotEmpty &&
          _reviewerNameController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.rate_review, size: 35),
            SizedBox(width: 9),
            Text('Create Employee Review', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          ],
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Theme.of(context).primaryColor, Theme.of(context).colorScheme.tertiary],
            begin: const Alignment(0.87, -1),
            end: const Alignment(-0.87, 1),
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Create New Employee Review',
                            style: Theme.of(context).textTheme.headlineSmall,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          _buildReadOnlyField(_employeeIdController, 'Employee ID'),
                          const SizedBox(height: 24),
                          _buildReadOnlyField(_employeeNameController, 'Employee Name'),
                          const SizedBox(height: 24),
                          _buildReadOnlyField(_jobTitleController, 'Job Title'),
                          const SizedBox(height: 24),
                          _buildTextField(_reviewPeriodController, 'Review Period'),
                          const SizedBox(height: 24),
                          _buildTextField(_reviewScoreController, 'Review Score', isNumeric: true),
                          const SizedBox(height: 24),
                          _buildTextField(_feedbackController, 'Feedback', maxLines: 3),
                          const SizedBox(height: 24),
                          _buildTextField(_reviewerNameController, 'Reviewer Name'),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: _isFormValid
                                ? () {
                              if (_formKey.currentState!.validate()) {
                                final newReview = PerformanceInput(
                                  employeeId: _employeeIdController.text,
                                  reviewPeriod: _reviewPeriodController.text,
                                  reviewScore: double.parse(_reviewScoreController.text),
                                  feedback: _feedbackController.text,
                                  reviewerName: _reviewerNameController.text,
                                );
                                api.createPerformance(newReview);
                                context.go('/employeePerformances',extra:widget.employee);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Employee review submitted successfully!')),
                                );
                              }
                            }
                                : null,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              backgroundColor: _isFormValid ? Colors.blue : Colors.grey,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child: const Text('Submit Review'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                OutlinedButton(
                  onPressed: () => context.go('/employeePerformances',extra:widget.employee),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Back'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReadOnlyField(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.grey[200],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {bool isNumeric = false, int? maxLines}) {
    return TextFormField(
      controller: controller,
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        if (isNumeric) {
          if (double.tryParse(value) == null) {
            return 'Please enter a valid number';
          }
        }
        return null;
      },
    );
  }
}