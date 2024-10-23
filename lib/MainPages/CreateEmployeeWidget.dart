import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrcentral_v2_ui/API_Calls/employeeAPI_Calls/EmployeeInput.dart';
import 'package:hrcentral_v2_ui/API_Calls/employeeAPI_Calls/employeeAPI.dart';


class CreateEmployeeWidget extends StatefulWidget {
  const CreateEmployeeWidget({super.key});

  @override
  State<CreateEmployeeWidget> createState() => _CreateEmployeeWidgetState();
}

class _CreateEmployeeWidgetState extends State<CreateEmployeeWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  final TextEditingController _jobPositionController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final employeeAPI api = employeeAPI();

  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _firstNameController.addListener(_validateForm);
    _lastNameController.addListener(_validateForm);
    _emailController.addListener(_validateForm);
    _departmentController.addListener(_validateForm);
    _jobPositionController.addListener(_validateForm);
    _phoneController.addListener(_validateForm);
    _addressController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _departmentController.dispose();
    _jobPositionController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _validateForm() {
    setState(() {
      _isFormValid = _firstNameController.text.isNotEmpty &&
          _lastNameController.text.isNotEmpty &&
          _emailController.text.isNotEmpty &&
          _departmentController.text.isNotEmpty &&
          _jobPositionController.text.isNotEmpty &&
          _phoneController.text.isNotEmpty &&
          _addressController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.person_add, size: 35),
            SizedBox(width: 9),
            Text('Create Employee', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
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
                            'Create New Employee',
                            style: Theme.of(context).textTheme.headlineSmall,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          _buildTextField(_firstNameController, 'First Name'),
                          const SizedBox(height: 24),
                          _buildTextField(_lastNameController, 'Last Name'),
                          const SizedBox(height: 24),
                          _buildTextField(_emailController, 'Email'),
                          const SizedBox(height: 24),
                          _buildTextField(_departmentController, 'Department'),
                          const SizedBox(height: 24),
                          _buildTextField(_jobPositionController, 'Job Position'),
                          const SizedBox(height: 24),
                          _buildTextField(_phoneController, 'Phone'),
                          const SizedBox(height: 24),
                          _buildTextField(_addressController, 'Home Address'),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: _isFormValid
                                ? () {
                              if (_formKey.currentState!.validate()) {
                                final newEmployee = EmployeeInput(
                                  firstName: _firstNameController.text,
                                  lastName: _lastNameController.text,
                                  email: _emailController.text,
                                  department: _departmentController.text,
                                  jobTitle: _jobPositionController.text,
                                  phone: _phoneController.text,
                                  address: _addressController.text,
                                );
                                api.createEmployee(newEmployee);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Add new employee successfully!')),
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
                            child: const Text('Create Employee'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                OutlinedButton(
                  onPressed: () => context.go('/employeesPage'),
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

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
