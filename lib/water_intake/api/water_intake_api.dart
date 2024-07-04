import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:pyramend/shared/componenets/constants/constants.dart';

class WaterIntakeApi {
  static String baseUrl = APIurlLocal;
  static const String token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2MTdjYWNjZTQyYjlkMDA0NDdmMzNmMyIsImlhdCI6MTcxOTI0MjQ3MSwiZXhwIjoxNzM2NTIyNDcxfQ.MF1FneqF4BegOcsDbZYTRyKRhRIJQ-ciCUYTFK2Cr_U';

  Future<Map<String, dynamic>> fetchWaterIntakeData(int inputTarget) async {
    final result = inputTarget == 0
        ? {"date": DateTime.now().toIso8601String()}
        : {
            "inputTarget": inputTarget,
            "date": DateTime.now().toIso8601String()
          };
    print('Sending request to $baseUrl/water/waterTarget');
    final response = await http.post(
      Uri.parse('$baseUrl/water/waterTarget'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(result),
    );
    print(response.statusCode);

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      print(jsonBody);
      return jsonBody;
    } else {
      throw Exception('Failed to load water intake data');
    }
  }

  Future<Map<String, dynamic>> addWaterConsumption(int amount) async {
    final dateFormatter = DateFormat('yyyy-MM-dd');
    final formattedDate = dateFormatter.format(DateTime.now());

    print('Sending request to $baseUrl/water/waterConsumption');
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
    print(response.statusCode);

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      print(jsonBody);
      return jsonBody;
    } else {
      throw Exception('Failed to add water consumption data');
    }
  }
}
