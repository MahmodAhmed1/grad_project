import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:pyramend/authentication/views/provider.dart';
import 'package:pyramend/authentication/views/sign_up.dart';
import 'package:pyramend/dashboard/views/home_page.dart';
import 'dart:convert';
import 'package:pyramend/meals/views/meal_view.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Add this import

import '../../health/views/health.dart';
import '../../shared/componenets/common_widgets/buttons.dart';
import '../../shared/componenets/common_widgets/text_fields.dart';
import '../../shared/componenets/constants/constants.dart';
import '../../shared/styles/colors/colors.dart';
import '../view_models/square_tile.dart';

class LogIn extends StatefulWidget {
  LogIn({Key? key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> logUserIn() async {
    String email = emailController.text;
    String password = passwordController.text;

    try {
      final response = await http.post(
        Uri.parse('$APIurlLocal/users/login'),
        body: jsonEncode({
          'email': "Fares777@gmail.com",
          'password': "Fares123",
        }),
        headers: {
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Login successful, handle response data
        final responseData = jsonDecode(response.body);
        if (responseData['status'] == 'success') {
          final user = responseData['data']['user'];
          print('User logged in successfully!');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Logged in successfully!'),
            ),
          );

          // Set the token in the UserProvider
          Provider.of<UserProvider>(context, listen: false).token =
              responseData['token'];
          Provider.of<UserProvider>(context, listen: false).userName =
              responseData['data']['name'];

          // Save login state in SharedPreferences
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', responseData['token']);
          await prefs.setString('userName', responseData['data']['name']);
          await prefs.setString('gender', responseData['data']['gender']);
          await prefs.setString('goal', responseData['data']['goal']);
          await prefs.setString(
              'activityLevel', responseData['data']['activityLevel']);
          await prefs.setString('email', responseData['data']['email']);
          await prefs.setInt('age', responseData['data']['age']);
          await prefs.setInt('height', responseData['data']['height']);
          await prefs.setInt('weight', responseData['data']['weight']);
          // Navigate to HomePage
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        } else {
          // Login failed
          print('Failed to log in: ${responseData['message']}');
          // Show an error message to the user
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to log in. ${responseData['message']}'),
            ),
          );
        }
      } else {
        // Login failed due to server error
        print('Failed to log in: ${response.statusCode}');
        final responseData = jsonDecode(response.body);

        // Show an error message to the user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to log in. ${responseData['message']}'),
          ),
        );
      }
    } catch (error) {
      // An error occurred
      print('Error logging in: $error');

      // Show an error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'An error occurred while logging in. Please try again later.'),
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
                        'Welcome Back!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: largeFotSize,
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.width * 0.04),
                      // Wrap input fields in a ListView for scrolling
                      ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          RoundedTextField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            hintText: 'Email',
                            prefixIconPath: 'assets/icons/email_icon.png',
                          ),
                          RoundedTextField(
                            controller: passwordController,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            hintText: 'Password',
                            prefixIconPath: 'assets/icons/password_icon.png',
                            obscureText: true,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 0, 1.2, 0),
                                child: const Text(
                                  'Forgot your password?',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    decoration: TextDecoration.underline,
                                    height: 1.5,
                                    color: Color(0xFFADA4A5),
                                    decorationColor: Color(0xFFADA4A5),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Static section with log-in button and other elements
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0.0),
                    Colors.white.withOpacity(1.0),
                  ],
                  stops: [0.0, 0.1], // Adjust stops as needed
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  // Adjust size as needed
                  RoundedButton(
                    onPressed: logUserIn,
                    width: double.maxFinite,
                    backgroundColor: Ucolor.DarkGray,
                    textColor: Ucolor.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/imgs/login.png',
                            height: 20, width: 19),
                        // Adjust size as needed
                        const SizedBox(width: 8),
                        // Adjust spacing as needed
                        Text(
                          'Log In',
                          style: TextStyle(
                            color: Ucolor.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignUp()),
                          );
                        },
                        child: Text(
                          'Sign Up',
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
