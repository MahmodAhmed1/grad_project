import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../shared/componenets/constants/constants.dart';
import 'log_in.dart';

class UserProvider with ChangeNotifier {
  String _token = '';
  late String _userName;

  String get token => _token;

  String get userName => _userName;
  List<Map<String, dynamic>> _meals = [];

  List<Map<String, dynamic>> get meals => _meals;

  set token(String value) {
    _token = value;

    notifyListeners();
  }

  set userName(String value) {
    _userName = value;
    notifyListeners();
  }

  Future<void> saveLoginState(String token, String userName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setString('userName', userName);

    _token = token;
    _userName = userName;
    notifyListeners();
  }

  Future<void> loadLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token') ?? '';
    _userName = prefs.getString('userName') ?? '';
    notifyListeners();
  }

  Future<void> clearLoginState(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('userName');
    _token = '';
    _userName = '';
    notifyListeners();

    // Directly navigate to the login page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LogIn()),
    );
  }

  bool get isLoggedIn => _token.isNotEmpty;

  Future<Map<String, dynamic>> getMedicine() async {
    try {
      final response = await http.get(
        Uri.parse('$APIurlLocal/medicine/getMedicine'),
        headers: {
          'Authorization': 'Bearer $_token',
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*'
        },
      );
      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load medicine');
      }
    } catch (e) {
      print('Error fetching medicine: $e');
      throw e; // Rethrow the exception to propagate it
    }
  }

  Future<Map<String, dynamic>> getMissedMedicines() async {
    try {
      final response = await http.get(
        Uri.parse('$APIurlLocal/medicine/missedMedicines'),
        headers: {
          'Authorization': 'Bearer $_token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load missed medicines');
      }
    } catch (e) {
      print('Error fetching missed medicines: $e');
      throw e;
    }
  }

  Future<void> updateMeal(BuildContext context, String mealName) async {
    try {
      final response = await http.patch(
        Uri.parse('$APIurlLocal/meal/updateMeal'),
        headers: {
          'Authorization': 'Bearer $_token',
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*'
        },
        body: jsonEncode({
          'mealName': mealName,
          'taken': true, // Assuming you have a similar property to update
        }),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Failed to update meal');
      }
      print(response.statusCode);
      print(response.body);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Meal updated successfully')),
      );

      fetchMeals(); // Refresh meals list after update
    } catch (e) {
      print('Error updating meal: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update meal')),
      );
      throw e;
    }
  }

  Future<void> deleteMeal(BuildContext context, String mealName) async {
    try {
      final response = await http.delete(
        Uri.parse('$APIurlLocal/meal/deleteMeal'),
        headers: {
          'Authorization': 'Bearer $_token',
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*'
        },
        body: jsonEncode({
          'mealName': mealName,
        }),
      );
      print(response.statusCode);
      print(response.body);

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Failed to delete meal');
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Meal deleted successfully')),
      );

      fetchMeals(); // Refresh meals list after deletion
    } catch (e) {
      print('Error deleting meal: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete meal')),
      );
      throw e;
    }
  }

  Future<void> updateMedicine(BuildContext context, String medName) async {
    try {
      final response = await http.patch(
        Uri.parse('$APIurlLocal/medicine/updateMedicine'),
        headers: {
          'Authorization': 'Bearer $_token',
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*'
        },
        body: jsonEncode({
          'medName': medName,
          'taken': true,
        }),
      );
      print(response.statusCode);
      print(response.body);
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Failed to update medicine');
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Medicine updated successfully')),
      );

      getMedicine();
    } catch (e) {
      print('Error updating medicine: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update medicine')),
      );
      throw e;
    }
  }

  Future<void> deleteMedicine(BuildContext context, String medName) async {
    try {
      final response = await http.delete(
        Uri.parse('$APIurlLocal/medicine/deleteMedicine'),
        headers: {
          'Authorization': 'Bearer $_token',
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*'
        },
        body: jsonEncode({
          'medName': medName,
        }),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Failed to delete medicine');
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Medicine deleted successfully')),
      );

      getMedicine();
    } catch (e) {
      print('Error deleting medicine: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete medicine')),
      );
      throw e;
    }
  }

  Future<bool> addMedicine({
    required String medName,
    required String dose,
    required String notificationHour,
    required int howLong,
    required String pillsDuration,
  }) async {
    final url = Uri.parse('$APIurlLocal/medicine/addMedicine');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $_token',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'medName': medName,
        'Dose': dose,
        'NotificationHour': notificationHour,
        'howLong': howLong,
        'pillsDuration': pillsDuration,
      }),
    );
    print('Add Medicine Response: ${response.statusCode}');
    print('Add Medicine Response Body: ${response.body}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      // Handle successful response
      notifyListeners();
      return true;
    } else {
      // Handle error response
      throw Exception('Failed to add medicine');
    }
  }

  Future<bool> addMeal({
    required String mealName,
    required String mealType,
    required String notificationHour,
    required int calories,
  }) async {
    final body = jsonEncode({
      'mealName': mealName,
      'mealType': mealType,
      'NotificationHour': notificationHour,
      'calories': calories,
    });

    try {
      final response = await http.post(
        Uri.parse('$APIurlLocal/meal/addMeal'),
        headers: {
          'Authorization': 'Bearer $_token',
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*'
        },
        body: body,
      );
      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        await fetchMeals(); // Refresh meals after adding a new meal
        return true;
      } else {
        throw Exception('Failed to add meal');
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  int totalMealsCalories = 0;
  int totalNeedCalories = 0;
  bool _isLoading = false; // Add isLoading property
  bool get isLoading => _isLoading;

  Future<void> fetchMeals() async {
    try {
      _isLoading = true; // Set isLoading to true before HTTP request
      notifyListeners();
      final response = await http.get(
        Uri.parse('$APIurlLocal/meal/getMeal'),
        headers: {
          'Authorization': 'Bearer $_token',
          "Access-Control-Allow-Origin": "",
          'Content-Type': 'application/json',
          'Accept': '/*'
        },
      );
      _isLoading = false; // Set isLoading to false after HTTP request
      notifyListeners();
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);

        if (responseData['data'] != null) {
          if (responseData['data'] is List) {
            _meals = List<Map<String, dynamic>>.from(responseData['data']);
          } else {
            _meals = [Map<String, dynamic>.from(responseData['data'])];
          }
          totalMealsCalories = responseData['totalMealsCalories'];
        } else {
          _meals = [];
          totalMealsCalories = 0;
        }
        totalNeedCalories = responseData['totalNeededCalories'];
        notifyListeners();
      } else {
        print('Failed to load meals: ${response.statusCode}');
        // Handle other status codes if needed
      }
    } catch (e) {
      _isLoading = false; // Ensure isLoading is set to false in case of error
      print('Error fetching meals: $e');
      throw e; // Rethrow the exception to propagate it if necessary
    }
  }

  Future<List<Map<String, dynamic>>> recommendMeals(
      List<String> preferences) async {
    final url = Uri.parse('$APIurlLocal/meal/recommendMeals');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_token',
        },
        body: json.encode({
          'preferences': preferences,
        }),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);

        if (responseBody['success'] == true) {
          final List<dynamic> mealsJson = responseBody['data'];
          final List<Map<String, dynamic>> recommendedMeals =
              mealsJson.cast<Map<String, dynamic>>();
          print("recommended meals: $recommendedMeals");
          return recommendedMeals;
        } else {
          throw Exception(
              'Failed to recommend meals: ${responseBody['message']}');
        }
      } else {
        throw Exception('Failed to recommend meals');
      }
    } catch (error) {
      throw error;
    }
  }
}
