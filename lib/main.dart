import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrcentral_v2_ui/API_Calls/employeeAPI_Calls/EmployeeDTO.dart';
import 'package:hrcentral_v2_ui/API_Calls/performanceAPI_Calls/PerformanceDTO.dart';
import 'package:hrcentral_v2_ui/Login&LogoutPages/ProfilePageWidget.dart';
import 'package:hrcentral_v2_ui/Login&LogoutPages/SettingPageWidget.dart';
import 'package:hrcentral_v2_ui/Login&LogoutPages/createAccountPages/CreateAccountWidget.dart';
import 'package:hrcentral_v2_ui/Login&LogoutPages/loginPages/SignInPage.dart';
import 'package:hrcentral_v2_ui/MainPages/CreateEmployeeWidget.dart';
import 'package:hrcentral_v2_ui/MainPages/DeleteEmployeePageWidget.dart';
import 'package:hrcentral_v2_ui/MainPages/EmployeeManagementWidget.dart';
import 'package:hrcentral_v2_ui/MainPages/performancePages/CreateEmployeeReviewWidget.dart';
import 'package:hrcentral_v2_ui/MainPages/performancePages/EmployeePerformancesWidget.dart';
import 'package:hrcentral_v2_ui/MainPages/performancePages/PerformanceProfilePageWidget.dart';
import 'package:hrcentral_v2_ui/firebase_options.dart';
import 'package:hrcentral_v2_ui/MainPages/HomePage.dart';
import 'package:hrcentral_v2_ui/MainPages/EmployeeProfilePageWidget.dart';

// Import your page widgets here

// import 'home_page.dart';
// import 'create_account_page.dart';
// import 'forgot_password_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'My Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const SignInPage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) =>  HomePage(),
    ),
    GoRoute(
      path: '/create-account',
      builder: (context, state) => const CreateAccountWidget(),
    ),
    GoRoute(
      path: '/setting',
      builder: (context, state) => const SettingPageWidget(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfilePageWidget(),
    ),
    GoRoute(
      path: '/employeesPage',
      builder: (context, state) => const EmployeeManagementWidget(),
    ),
    GoRoute(
      path: '/createEmployee',
      builder: (context, state) => const CreateEmployeeWidget(),
    ),
    GoRoute(
      path: '/employeeProfile',
      builder: (context, state) {
        final employee = state.extra as EmployeeDTO;  // Cast the extra to EmployeeDTO
        return EmployeeProfilePageWidget(employee: employee);
      },
    ),
    GoRoute(
      path: '/deleteEmployee',
      builder: (context, state) {
        final employee = state.extra as EmployeeDTO;  // Cast the extra to EmployeeDTO
        return DeleteEmployeePageWidget(employee: employee);
      },
    ),
    GoRoute(
      path: '/employeePerformances',
      builder: (context, state) {
        final employee = state.extra as EmployeeDTO;  // Cast the extra to EmployeeDTO
        return EmployeePerformancesWidget(employee: employee);
      },
    ),
    GoRoute(
      path: '/employeePerformanceDetail',
      builder: (context, state) {
        final data = state.extra as Map<String, dynamic>; // Cast the extra as a Map
        final performance = data['performance'] as PerformanceDTO;
        final employee = data['employee'] as EmployeeDTO;

        return PerformanceProfilePageWidget(
          performance: performance,
          employee: employee,
        );
      },
    ),
    GoRoute(
      path: '/createEmployeeReview',
      builder: (context, state) {
        final employee = state.extra as EmployeeDTO;  // Cast the extra to EmployeeDTO
        return CreateEmployeeReviewWidget(employee: employee);
      },
    ),
  ],
);
