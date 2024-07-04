import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pyramend/fitness/data/models/workout_model.dart';
import 'package:pyramend/shared/componenets/constants/constants.dart';

class WorkoutService {
  // static const String baseUrl = 'http://10.0.2.2:3000/api/';

  static String baseUrl = APIurlLocal;
  static String userToken = token;

  static Future<List<Workout>> getWorkoutsForDate(int date) async {
    print('Sending request to $baseUrl/workouts/$date');
    final response = await http.get(
      Uri.parse('$baseUrl/workouts/$date'),
      headers: {
        'Authorization': 'Bearer $userToken',
        'Content-Type': 'application/json',
      },
    );
    print('Response status code: ${response.statusCode}');

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Workout.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load workouts');
    }
  }

  static Future<List<Workout>> getAllWorkouts() async {
    print('Sending request to $baseUrl/workouts');
    final response = await http.get(
      Uri.parse('$baseUrl/workouts'),
      headers: {
        'Authorization': 'Bearer $userToken',
        'Content-Type': 'application/json',
      },
    );
    print('Response status code: ${response.statusCode}');

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Workout.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load workouts');
    }
  }

  static Future<Workout> addWorkout(List<String> exercises, int date) async {
    final response = await http.post(
      Uri.parse('$baseUrl/workouts'),
      headers: {
        'Authorization': 'Bearer $userToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'exercises': exercises,
        'date': date,
      }),
    );

    if (response.statusCode == 201) {
      return Workout.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add workout');
    }
  }
}
