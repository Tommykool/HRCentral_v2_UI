import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrcentral_v2_ui/API_Calls/employeeAPI_Calls/EmployeeDTO.dart';
import 'package:hrcentral_v2_ui/API_Calls/employeeAPI_Calls/employeeAPI.dart';


class EmployeeManagementWidget extends StatefulWidget {
  const EmployeeManagementWidget({super.key});

  @override
  _EmployeeManagementWidgetState createState() => _EmployeeManagementWidgetState();
}

class _EmployeeManagementWidgetState extends State<EmployeeManagementWidget> {
  final TextEditingController _searchController = TextEditingController();
  late Future<List<EmployeeDTO>> _futureEmployees;
  final employeeAPI api = employeeAPI();
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _futureEmployees = api.fetchEmployees(); // Call to fetch employee list
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.go('/home'),
        ),
        title: const Text(
            'Employee Management', style: TextStyle(color: Colors.white)),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green, Colors.blue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 68),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SearchBar(
                    controller: _searchController,
                    hintText: 'Search by Employee ID',
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Employee List',
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleLarge,
                  ),
                  const SizedBox(height: 16),
                  FutureBuilder<List<EmployeeDTO>>(
                    future: _futureEmployees,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No employees found.'));
                      } else {
                        final employees = snapshot.data!;
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: employees.length,
                          itemBuilder: (context, index) {
                            final employee = employees[index];
                            return EmployeeCard(
                              name: '${employee.firstName} ${employee
                                  .lastName}',
                              position: employee.jobTitle,
                              employee: employee,
                              onEdit: () {
                                // Handle edit
                              },
                              onDelete: () {
                               context.go('/deleteEmployee',extra: employee);
                              }, id: '',
                            );
                          },
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: FloatingActionButton.extended(
                onPressed: () {
                  context.go('/createEmployee');
                },
                icon: const Icon(Icons.add),
                label: const Text('Add New Employee'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const SearchBar({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }
}

class EmployeeCard extends StatelessWidget {
  final String name;
  final String id;
  final String position;
  final EmployeeDTO employee;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const EmployeeCard({
    super.key,
    required this.name,
    required this.id,
    required this.employee,
    required this.position,
    required this.onEdit,
    required this.onDelete,
  });


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Handle tap action here
        context.go('/employeeProfile', extra: employee);
      },
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            child: Text(name.substring(0, 2)),
          ),
          title: Text(name),
          subtitle: Text(position),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: onDelete,
              ),
            ],
          ),
        ),
      ),
    );
  }

}