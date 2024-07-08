import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../on_boarding/onboarding_page1.dart';
import '../../shared/componenets/common_widgets/buttons.dart';
import '../../shared/componenets/common_widgets/text_fields.dart';
import '../../shared/componenets/constants/constants.dart';
import '../../shared/styles/colors/colors.dart';
import '../view_models/square_tile.dart';
import 'log_in.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  String? selectedActivityLevel;
  String? selectedGoal;
  String? selectedGender;

  final List<String> activityLevels = [
    'moderately active',
    'lightly active',
    'very active',
    'extra active',
    'sedentary'
  ];
  final List<String> goals = ['gain weight', 'lose weight', 'maintain weight'];
  final List<String> genders = ['male', 'female', 'other'];

  Future<void> signUserUp() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    String name = nameController.text;
    String email = emailController.text;
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;
    int age = int.tryParse(ageController.text) ?? 0;
    int height = int.tryParse(heightController.text) ?? 0;
    int weight = int.tryParse(weightController.text) ?? 0;

    try {
      final response = await http.post(
        Uri.parse('$APIurlLocal/users/signUp'),
        body: jsonEncode({
          'name': name,
          'email': email,
          'age': age,
          'height': height,
          'weight': weight,
          'activityLevel': selectedActivityLevel ?? '',
          'goal': selectedGoal ?? '',
          'gender': selectedGender ?? '',
          'password': password,
          'confirmPassword': confirmPassword,
        }),
        headers: {
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*',
        },
      );
      final responseData = jsonDecode(response.body);
      if (response.statusCode == 201 || response.statusCode == 200) {
        print('Response: $responseData');
        if (responseData['status'] == 'success') {
          print('Message: ${responseData['message']}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  Text('Signed up successfully! ${responseData['message']}'),
            ),
          );

          // Show the pop-up message
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Email Verification'),
                content: Text(
                    'We have sent a verification email to your address. Please verify it to start mending your life!'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OnboardingPage1()),
                      );
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        } else {
          print('Failed to sign up: ${responseData['message']}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to sign up. ${responseData['message']}'),
            ),
          );
        }
      } else {
        print('Failed to sign up: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to sign up. ${responseData['message']}'),
          ),
        );
      }
    } catch (error) {
      print('Error signing up: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'An error occurred while signing up. Please try again later.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Ucolor.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.width * 0.04),
                      Text(
                        'Hey there,',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: smallFotSize,
                        ),
                      ),
                      Text(
                        'Create an account',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: largeFotSize,
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.width * 0.04),
                      Form(
                        key: _formKey,
                        child: ListView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            RoundedTextField(
                              controller: nameController,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              hintText: 'Name',
                              prefixIconPath:
                                  'assets/icons/profile_menu_icon.png',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your name';
                                }
                                return null;
                              },
                            ),
                            RoundedTextField(
                              controller: passwordController,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              hintText: 'Password',
                              prefixIconPath: 'assets/icons/password_icon.png',
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                } else if (value.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
                            ),
                            RoundedTextField(
                              controller: confirmPasswordController,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              hintText: 'Confirm Password',
                              prefixIconPath: 'assets/icons/password_icon.png',
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please confirm your password';
                                } else if (value != passwordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                            ),
                            RoundedTextField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              hintText: 'Email',
                              prefixIconPath: 'assets/icons/email_icon.png',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                    .hasMatch(value)) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                            ),
                            RoundedTextField(
                              keyboardType: TextInputType.numberWithOptions(),
                              controller: weightController,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              hintText: 'Weight in KG',
                              prefixIconPath: 'assets/icons/weight_icon.png',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your weight';
                                } else if (int.tryParse(value) == null) {
                                  return 'Please enter a valid weight';
                                }
                                return null;
                              },
                            ),
                            RoundedTextField(
                              keyboardType: TextInputType.numberWithOptions(),
                              controller: heightController,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              hintText: 'Height in CM',
                              prefixIconPath: 'assets/icons/height_icon.png',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your height';
                                } else if (int.tryParse(value) == null) {
                                  return 'Please enter a valid height';
                                }
                                return null;
                              },
                            ),
                            RoundedTextField(
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: false),
                              controller: ageController,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              hintText: 'Age',
                              prefixIconPath: 'assets/icons/age_icon.png',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your age';
                                } else if (int.tryParse(value) == null) {
                                  return 'Please enter a valid age';
                                }
                                return null;
                              },
                            ),
                            RoundedTextField(
                              hintText: 'Gender',
                              prefixIconPath: 'assets/icons/gender_icon.png',
                              margin: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              dropdownItems: genders,
                              onChanged: (value) {
                                setState(() {
                                  selectedGender = value;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select your gender';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 10),
                            RoundedTextField(
                              hintText: 'Activity Level',
                              margin: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              prefixIconPath: 'assets/icons/activity_icon.png',
                              dropdownItems: activityLevels,
                              onChanged: (value) {
                                setState(() {
                                  selectedActivityLevel = value;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select your activity level';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 10),
                            RoundedTextField(
                              hintText: 'Goal',
                              margin: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              prefixIconPath: 'assets/icons/goal_icon.png',
                              dropdownItems: goals,
                              onChanged: (value) {
                                setState(() {
                                  selectedGoal = value;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select your goal';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0.0),
                    Colors.white.withOpacity(1.0),
                  ],
                  stops: [0.0, 0.1],
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  RoundedButton(
                    width: double.maxFinite,
                    title: 'Register',
                    onPressed: signUserUp,
                    backgroundColor: Ucolor.DarkGray,
                    textColor: Ucolor.white,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LogIn()),
                          );
                        },
                        child: Text(
                          'Log In',
                          style: TextStyle(
                            color: Ucolor.primaryColor2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
