import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrcentral_v2_ui/Components/BottomNavBarWidget.dart';
import 'package:hrcentral_v2_ui/FirebaseServices/authService/AuthService.dart';

class ProfilePageWidget extends StatefulWidget {
  const ProfilePageWidget({super.key});

  @override
  State<ProfilePageWidget> createState() => _ProfilePageWidgetState();
}

class _ProfilePageWidgetState extends State<ProfilePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late TextEditingController _phoneController;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late FocusNode _phoneFocusNode;
  late FocusNode _nameFocusNode;
  late FocusNode _emailFocusNode;
  final AuthService authService = AuthService();
  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController(text: 'Current Phone Number');
    _nameController = TextEditingController(text: 'Current User Name');
    _emailController = TextEditingController(text: 'Current User Email');
    _phoneFocusNode = FocusNode();
    _nameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneFocusNode.dispose();
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: const Text('Profile'),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 209,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue, Colors.purple],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage('https://example.com/profile.jpg'),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'User Name',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 50, 50, 99),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Role', style: TextStyle(color: Colors.grey)),
                        const Text('User Role'),
                        const SizedBox(height: 16),
                        const Text('Phone Number', style: TextStyle(color: Colors.grey)),
                        TextField(
                          controller: _phoneController,
                          focusNode: _phoneFocusNode,
                          decoration: const InputDecoration(
                            hintText: '+1 (555) 123-4567',
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text('Display Name', style: TextStyle(color: Colors.grey)),
                        TextField(
                          controller: _nameController,
                          focusNode: _nameFocusNode,
                          decoration: const InputDecoration(
                            hintText: 'John Doe',
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text('Email', style: TextStyle(color: Colors.grey)),
                        TextField(
                          controller: _emailController,
                          focusNode: _emailFocusNode,
                          decoration: const InputDecoration(
                            hintText: 'john.doe@example.com',
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text('UID', style: TextStyle(color: Colors.grey)),
                        const Text('User UID'),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () async {
                            // Update profile logic here
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          child: const Text('Update Profile'),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            authService.signout();
                            context.go('/login');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          child: const Text('Logout',style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Padding(padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: BottomNavBarWidget(
                    onItemSelected: (String routeName) {
                      context.go(routeName); // Use go_router to navigate
                    },
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}