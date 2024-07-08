import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:pyramend/shared/componenets/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WaterIntakeApi {
  static String baseUrl = APIurlLocal;

  Future<Map<String, dynamic>> fetchWaterIntakeData(int inputTarget) async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    final dateFormatter = DateFormat('yyyy-MM-dd');
    final formattedDate = dateFormatter.format(DateTime.now());
    final result = inputTarget == 0
        ? {"date": formattedDate}
        : {"date": formattedDate, "inputTarget": inputTarget};

    final response = await http.post(
      Uri.parse('$baseUrl/water/waterTarget'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(result),
    );
    print(
        'Sending request to $baseUrl/water/waterTarget with status code: ${response.statusCode}');

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      return jsonBody;
    } else {
      throw Exception('Failed to load water intake data');
    }
  }

  Future<Map<String, dynamic>> addWaterConsumption(int amount) async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    final dateFormatter = DateFormat('yyyy-MM-dd');
    final formattedDate = dateFormatter.format(DateTime.now());

    final response = await http.post(
      Uri.parse('$baseUrl/water/waterConsumption'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        {
          "amount": amount,
          "date": formattedDate,
        },
      ),
    );
    print(
        'Sending request to $baseUrl/water/waterConsumption with status code: ${response.statusCode}');

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      return jsonBody;
    } else {
      throw Exception('Failed to add water consumption data');
    }
  }
}
