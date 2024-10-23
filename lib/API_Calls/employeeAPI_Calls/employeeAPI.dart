import 'package:hrcentral_v2_ui/API_Calls/employeeAPI_Calls/EmployeeDTO.dart';
import 'package:hrcentral_v2_ui/API_Calls/employeeAPI_Calls/EmployeeInput.dart';
import 'package:hrcentral_v2_ui/FirebaseServices/authService/AuthService.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For JSON decoding


class employeeAPI {
  AuthService authService = AuthService();
  String baseUrl = 'http://10.150.2.166:8081/api/employees';

  Future<List<EmployeeDTO>> fetchEmployees() async {
    final token = await authService.getFirebaseToken();
    
    if (token == null) {
      throw Exception("User is not authenticated");
    }
    else {
      print('==========================================================>' + token);
    }

    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> employeesJson = jsonDecode(response.body);
      return employeesJson.map((json) => EmployeeDTO.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load employees');
    }
  }

  Future<void> createEmployee(EmployeeInput employee) async {
    //const String url = 'http://10.14.76.94:8081/api/employees';
    final token = await authService.getFirebaseToken();
    if (token == null) {
      throw Exception("User is not authenticated");
    }

    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(employee.toJson()),
    );

    if (response.statusCode == 201) {
      print('Employee created successfully');
    } else {
      print('Failed to create employee: ${response.body}');
    }
  }

  Future<void> updateEmployee(String id, EmployeeInput employee) async {
    final String url = '$baseUrl/$id';
    final token = await authService.getFirebaseToken();
    if (token == null) {
      throw Exception("User is not authenticated");
    }

    final response = await http.put(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(employee.toJson()),
    );

    if (response.statusCode == 200) {
      print('Employee updated successfully');
    } else if (response.statusCode == 404) {
      print('Employee not found');
    } else {
      print('Failed to update employee: ${response.body}');
    }
  }

  Future<void> deleteEmployee(String id) async {
    final String url = '$baseUrl/$id';

    final token = await authService.getFirebaseToken();
    if (token == null) {
      throw Exception("User is not authenticated");
    }

    final response = await http.delete(
      Uri.parse(url),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 204) {
      // Employee deleted successfully
      print('Employee deleted successfully.');
    } else if (response.statusCode == 404) {
      // Employee not found
      print('Employee not found.');
    } else {
      // Error handling
      print('Failed to delete employee: ${response.statusCode}');
    }
  }





}
