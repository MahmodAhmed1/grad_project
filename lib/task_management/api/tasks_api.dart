import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pyramend/authentication/views/provider.dart';
import 'package:pyramend/shared/componenets/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskService {
  static String baseUrl = APIurlLocal;

  // static String userToken = token;

  Future<List<dynamic>> fetchTasks() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String userToken = prefs.getString('token') ?? '';
      final response = await http.get(
        Uri.parse('$baseUrl/task/getTasks'),
        headers: {
          'Authorization': 'Bearer $userToken',
          'Content-Type': 'application/json',
        },
      );
      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 201) {
        final Map<String, dynamic> data = jsonDecode(response.body);
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
      final prefs = await SharedPreferences.getInstance();
      String userToken = prefs.getString('token') ?? '';
      final response = await http.post(
        Uri.parse('$baseUrl/task/addTask'),
        headers: {
          'Authorization': 'Bearer $userToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(taskData),
      );
      print('Response status code: ${response.statusCode}');

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
      final prefs = await SharedPreferences.getInstance();
      String userToken = prefs.getString('token') ?? '';
      // String userName = prefs.getString('userName') ?? '';
      // String activityLevel = prefs.getString('activityLevel') ?? '';
      // String gender = prefs.getString('gender') ?? '';
      // String goal = prefs.getString('goal') ?? '';
      // String email = prefs.getString('email') ?? '';
      // int height = prefs.getInt('height') ?? 0;
      // int age = prefs.getInt('age') ?? 0;
      // int weight = prefs.getInt('weight') ?? 0;
      // print('User Details:');
      // print('Username: $userName');
      // print('Activity Level: $activityLevel');
      // print('Gender: $gender');
      // print('Goal: $goal');
      // print('Email: $email');
      // print('Height: $height');
      // print('Age: $age');
      // print('Weight: $weight');
      // print('Sending request to $baseUrl/task/getTasks');
      final modifiedFilter = filter.map((key, value) {
        if (value is DateTime) {
          return MapEntry(key, value.toIso8601String().substring(0, 10));
        }
        return MapEntry(key, value);
      });

      print('Sending request to $baseUrl/task/getTasksByFilter');
      final response = await http.post(
        Uri.parse('$baseUrl/task/getTasksByFilter'),
        headers: {
          'Authorization': 'Bearer $userToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(modifiedFilter),
      );
      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data['data'] != null) {
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
      final prefs = await SharedPreferences.getInstance();
      String userToken = prefs.getString('token') ?? '';
      print('Sending request to $baseUrl/task/deleteTask');

      final response = await http.delete(
        Uri.parse('$baseUrl/task/deleteTask'),
        headers: {
          'Authorization': 'Bearer $userToken',
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
      final prefs = await SharedPreferences.getInstance();
      String userToken = prefs.getString('token') ?? '';
      print('Sending request to $baseUrl/task/updateTask');
      final response = await http.patch(
        Uri.parse('$baseUrl/task/updateTask'),
        headers: {
          'Authorization': 'Bearer $userToken',
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
