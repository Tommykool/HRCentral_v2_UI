import 'package:hrcentral_v2_ui/API_Calls/performanceAPI_Calls/PerformanceInput.dart';
import 'package:hrcentral_v2_ui/FirebaseServices/authService/AuthService.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'PerformanceDTO.dart';

class PerformanceAPIService {
  final AuthService authService = AuthService();
  final String baseUrl = 'http://10.150.2.166:8082/api/performances';

  Future<List<PerformanceDTO>> fetchPerformanceDatabyEmployeeId(String employeeId) async {
    final url = Uri.parse('$baseUrl/employee/$employeeId');
    print('EmployeeId==========' + employeeId);

    final token = await authService.getFirebaseToken();

    if (token == null) {
      throw Exception("User is not authenticated");
    } else {
      print('==========================================================>' + token);
    }

    try {
      final response = await http.get(
        url,  // Use the correct URL here
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> responseData = jsonDecode(response.body);
        print(responseData.toString());
        return responseData.map((json) => PerformanceDTO.fromJson(json)).toList();
      } else if (response.statusCode == 404) {
        // If no performances found, return an empty list
        return [];
      } else {
        throw Exception('Failed to load performances: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching performances: $e');
      throw Exception('Failed to load performances: $e');
    }
  }

  Future<void> deletePerformance(int id) async {
    final url = Uri.parse('$baseUrl/$id');
    final AuthService authService = AuthService();
    final token = await authService.getFirebaseToken();

    final response = await http.delete(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 204) {
      print('Performance deleted successfully');
    } else {
      throw Exception('Failed to delete performance. Status code: ${response.statusCode}');
    }
  }


  Future<PerformanceDTO> createPerformance(PerformanceInput performanceDTO) async {
    final url = Uri.parse(baseUrl); // Replace with your actual API URL
    final AuthService authService = AuthService();
    final token = await authService.getFirebaseToken();

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(performanceDTO.toJson()),
    );

    if (response.statusCode == 201) {
      return PerformanceDTO.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create performance');
    }
  }

}