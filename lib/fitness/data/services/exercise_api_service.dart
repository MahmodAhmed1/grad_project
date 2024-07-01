import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pyramend/fitness/data/models/exercise_model.dart';

class ExerciseService {
  static const String baseUrl = 'http://10.0.2.2:3000/fitness/exercises';

  // Function to fetch all exercises
  static Future<List<Exercise>> getAllExercises() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        List<Exercise> exercises =
            data.map((json) => Exercise.fromJson(json)).toList();
        return exercises;
      } else {
        throw Exception('Failed to fetch exercises');
      }
    } catch (error) {
      throw Exception('Failed to fetch exercises: $error');
    }
  }

  // Function to fetch exercises by body part
  static Future<List<Exercise>> fetchExercisesByBodyPart(
      String bodyPart) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/fetch/$bodyPart'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);
        final List<dynamic> data = responseBody['exercises'];
        List<Exercise> exercises =
            data.map((json) => Exercise.fromJson(json)).toList();
        return exercises;
      } else {
        throw Exception('Failed to fetch exercises by body part');
      }
    } catch (error) {
      throw Exception('Failed to fetch exercises by body part: $error');
    }
  }

  // Function to fetch exercise by ID
  static Future<Exercise> fetchExerciseById(String id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$id'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);
        final Exercise exercise = Exercise.fromJson(responseBody['exercise']);
        return exercise;
      } else {
        throw Exception('Failed to fetch exercise');
      }
    } catch (error) {
      throw Exception('Failed to fetch exercise: $error');
    }
  }

  // Function to create a new exercise
  static Future<Exercise> createExercise(Exercise exercise) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(exercise.toJson()),
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> responseBody = json.decode(response.body);
        final createdExercise = Exercise.fromJson(responseBody['exercise']);
        return createdExercise;
      } else {
        throw Exception('Failed to create exercise');
      }
    } catch (error) {
      throw Exception('Failed to create exercise: $error');
    }
  }

  // Function to update exercise by ID
  static Future<Exercise> updateExercise(
      String id, Exercise updatedExercise) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(updatedExercise.toJson()),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);
        final updatedExercise = Exercise.fromJson(responseBody['exercise']);
        return updatedExercise;
      } else {
        throw Exception('Failed to update exercise');
      }
    } catch (error) {
      throw Exception('Failed to update exercise: $error');
    }
  }

  // Function to delete exercise by ID
  static Future<void> deleteExercise(String id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/$id'));
      if (response.statusCode != 204) {
        throw Exception('Failed to delete exercise');
      }
    } catch (error) {
      throw Exception('Failed to delete exercise: $error');
    }
  }

  // Function to get exercise weight by ID
  static Future<int> getExerciseWeight(String id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$id/weight'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);
        final int weight = responseBody['weight'];
        return weight;
      } else {
        throw Exception('Failed to fetch exercise weight');
      }
    } catch (error) {
      throw Exception('Failed to fetch exercise weight: $error');
    }
  }

  // Function to set exercise weight by ID
  static Future<int> setExerciseWeight(String id, int weight) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/$id/weight'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'weight': weight}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);
        final int updatedWeight = responseBody['weight'];
        return updatedWeight;
      } else {
        throw Exception('Failed to update exercise weight');
      }
    } catch (error) {
      throw Exception('Failed to update exercise weight: $error');
    }
  }

  // Function to get exercise repetitions by ID
  static Future<int> getExerciseRepetitions(String id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$id/repeats'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);
        final int repetitions = responseBody['repetitions'];
        return repetitions;
      } else {
        throw Exception('Failed to fetch exercise repetitions');
      }
    } catch (error) {
      throw Exception('Failed to fetch exercise repetitions: $error');
    }
  }

  // Function to set exercise repetitions by ID
  static Future<int> setExerciseRepetitions(String id, int repetitions) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/$id/repeats'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'repeats': repetitions}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);
        final int updatedRepetitions = responseBody['repetitions'];
        return updatedRepetitions;
      } else {
        throw Exception('Failed to update exercise repetitions');
      }
    } catch (error) {
      throw Exception('Failed to update exercise repetitions: $error');
    }
  }

  // Function to get exercise sets by ID
  static Future<int> getExerciseSets(String id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$id/sets'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);
        final int sets = responseBody['sets'];
        return sets;
      } else {
        throw Exception('Failed to fetch exercise sets');
      }
    } catch (error) {
      throw Exception('Failed to fetch exercise sets: $error');
    }
  }

  // Function to set exercise sets by ID
  static Future<int> setExerciseSets(String id, int sets) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/$id/sets'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'sets': sets}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);
        final int updatedSets = responseBody['sets'];
        return updatedSets;
      } else {
        throw Exception('Failed to update exercise sets');
      }
    } catch (error) {
      throw Exception('Failed to update exercise sets: $error');
    }
  }
}
