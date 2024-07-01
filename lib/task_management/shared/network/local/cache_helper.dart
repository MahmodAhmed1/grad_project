// import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putData(key, value) async {
    return await sharedPreferences.setBool(key, value);
  }

  static bool? getData(key) {
    return sharedPreferences.getBool(key);
  }
}
