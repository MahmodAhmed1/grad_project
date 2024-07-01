import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pyramend/shared/componenets/constants/constants.dart';

class TaskService {
  static String baseUrl = APIurlLocal;
  static const String token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2MTdjYWNjZTQyYjlkMDA0NDdmMzNmMyIsImlhdCI6MTcxOTE4ODIxMCwiZXhwIjoxNzM2NDY4MjEwfQ.rIPiocJB77rmAnw4uyi_u_hG3BLCGc7DSdUiB_Kty1U';

  Future<List<dynamic>> fetchTasks() async {
    try {
      print('Sending request to $baseUrl/task/getTasks');
      final response = await http.get(
        Uri.parse('$baseUrl/task/getTasks'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      // print('Response status code: ${response.statusCode}');
      // print('Response body: ${response.body}');

      if (response.statusCode == 201) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        // print(data['data']);
        return data['data'];
      } else {
        throw Exception('Failed to load tasks: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception while fetching tasks: $e');
      throw Exception('Failed to load tasks');
    }
  }

  Future<Map<String, dynamic>> addTask(Map<String, dynamic> taskData) async {
    try {
      print('Sending request to $baseUrl/task/addTask');
      final response = await http.post(
        Uri.parse('$baseUrl/task/addTask'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(taskData),
      );
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      final responseData = jsonDecode(response.body);

      if (response.statusCode != 201) {
        return {'message': responseData["message"], 'success': false};
      } else {
        return {'message': responseData["message"], 'success': true};
      }
    } catch (e) {
      print('Exception while adding task: $e');
      return {'message': 'Failed to add task', 'success': false};
    }
  }

  Future<List<dynamic>> fetchTasksByFilter(Map<String, dynamic> filter) async {
    try {
      // Convert DateTime objects to ISO 8601 strings
      print(filter);

      final modifiedFilter = filter.map((key, value) {
        if (value is DateTime) {
          return MapEntry(key, value.toIso8601String().substring(0, 10));
        }
        return MapEntry(key, value);
      });

      print(modifiedFilter);

      print('Sending request to $baseUrl/task/getTasksByFilter');
      final response = await http.post(
        Uri.parse('$baseUrl/task/getTasksByFilter'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(modifiedFilter),
      );
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data['data'] != null) {
          // print(data['data']);
          return data['data'];
        } else {
          return [];
        }
      } else {
        throw Exception('Failed to load tasks: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception while fetching tasks: $e');
      throw Exception('Failed to load tasks');
    }
  }

  Future<Map<String, dynamic>> deleteTask(String taskName) async {
    try {
      print('Sending request to $baseUrl/task/deleteTask');
      final response = await http.delete(
        Uri.parse('$baseUrl/task/deleteTask'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'taskName': taskName,
        }),
      );
      print('Response status code: ${response.statusCode}');

      final responseData = jsonDecode(response.body);
      if (response.statusCode != 200) {
        return {'message': responseData["message"], 'success': false};
      } else {
        return {'message': responseData["success"], 'success': true};
      }
    } catch (e) {
      print('Exception while deleting task: $e');
      throw Exception('Failed to delete task');
    }
  }

  Future<Map<String, dynamic>> updateTask(
      Map<String, dynamic> updatedData) async {
    try {
      print('Sending request to $baseUrl/task/updateTask');
      final response = await http.patch(
        Uri.parse('$baseUrl/task/updateTask'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(updatedData),
      );
      print('Response status code: ${response.statusCode}');
      final responseData = jsonDecode(response.body);
      if (response.statusCode != 200) {
        return {'message': responseData["message"], 'success': false};
        // throw Exception('Failed to update task: ${response.statusCode}');
      } else {
        return {'message': responseData["success"], 'success': true};
      }
    } catch (e) {
      print('Exception while updating task: $e');
      throw Exception('Failed to update task');
    }
  }
}
