import 'dart:ui';
import 'package:flutter/material.dart';

// add color from figma ui here..
class Ucolor {
  static Color get primaryColor1 => const Color(0xff8FEDE2);
  static Color get primaryColor2 => const Color(0xff9DCEFF);
  static List<Color> get primaryG => [primaryColor2, primaryColor1];

  // Fitness Colors
  static Color get fitnessPrimaryColor1 => Color.fromARGB(124, 241, 108, 148);
  static Color get fitnessPrimaryColor2 => Color.fromARGB(255, 72, 93, 202);

  static List<Color> get fitnessPrimaryColors =>
      [fitnessPrimaryColor1, fitnessPrimaryColor2];

  static LinearGradient fitnessGradient = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: Ucolor.fitnessPrimaryColors,
    stops: [0.01, 1.0],
  );

  // Meal Colors
  static Color get mealsPrimaryColor1 => Color.fromARGB(165, 232, 106, 68);
  static Color get mealsPrimaryColor2 => Color.fromARGB(174, 222, 187, 10);
  static List<Color> get mealsPrimaryGradient =>
      [mealsPrimaryColor1, mealsPrimaryColor2];

  // Task Colors
  static Color get taskPrimaryColor1 => const Color(0xff8FEDE2);
  static Color get taskPrimaryColor2 => const Color(0xff9DCEFF);
  static List<Color> get taskPrimaryGradient =>
      [taskPrimaryColor1, taskPrimaryColor2];

  // Health Colors
  static Color get healthPrimaryColor1 => const Color(0xff8FEDE2);
  static Color get healthPrimaryColor2 => const Color(0xff9DCEFF);
  static List<Color> get healthPrimaryGradient =>
      [healthPrimaryColor1, healthPrimaryColor2];

  // Water Colors
  static Color get waterPrimaryColor1 => const Color(0xff8FEDE2);
  static Color get waterPrimaryColor2 => const Color(0xff9DCEFF);
  static List<Color> get waterPrimaryGradient =>
      [waterPrimaryColor1, waterPrimaryColor2];

// Logo Colors
  static Color get logoGreenColor1 => const Color(0xFF31C48D);
  static Color get logoGreenColor2 => const Color(0x9631c48d);
  static List<Color> get logoGreenG => [logoGreenColor2, logoGreenColor1];

// common colors
  static Color get black => const Color(0xff1D1617);
  static Color get white => const Color(0xffFFFFFF);
  static Color get gray => const Color(0xff7B6F72);
  static Color get lightGray => const Color(0xffF7F8F8);
  static Color get DarkGray => const Color(0xbe313431);
}
