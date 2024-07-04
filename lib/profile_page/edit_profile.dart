import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pyramend/profile_page/user_profile_widget.dart';
import 'package:pyramend/task_management/shared/components/components.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../shared/componenets/common_widgets/buttons.dart';
import '../../shared/componenets/common_widgets/text_fields.dart';
import '../../shared/componenets/constants/constants.dart';
import '../../shared/styles/colors/colors.dart';

class EditProfile extends StatefulWidget {
  EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController ageController;
  late TextEditingController heightController;
  late TextEditingController weightController;

  String? selectedActivityLevel;
  String? selectedGoal;
  String? selectedGender;

  final List<String> activityLevels = [
    'sedentary',
    'lightly active',
    'moderately active',
    'very active',
    'extra active'
  ];
  final List<String> goals = ['lose weight', 'maintain weight', 'gain weight'];
  final List<String> genders = ['male', 'female'];

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _loadUserData();
  }

  void _initializeControllers() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    ageController = TextEditingController();
    heightController = TextEditingController();
    weightController = TextEditingController();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nameController.text = prefs.getString('userName') ?? '';
      selectedActivityLevel = prefs.getString('activityLevel');
      selectedGender = prefs.getString('gender');
      selectedGoal = prefs.getString('goal');
      emailController.text = prefs.getString('email') ?? '';
      heightController.text = (prefs.getInt('height') ?? 0).toString();
      ageController.text = (prefs.getInt('age') ?? 0).toString();
      weightController.text = (prefs.getInt('weight') ?? 0).toString();
    });
  }

  static String baseUrl = APIurlLocal;
  Future<void> updateUserProfile() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    String name = nameController.text;
    int age = int.tryParse(ageController.text) ?? 0;
    int height = int.tryParse(heightController.text) ?? 0;
    int weight = int.tryParse(weightController.text) ?? 0;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    try {
      print('Name: $name');
      print('Age: $age');
      print('Height: $height');
      print('Weight: $weight');
      print('Activity Level: ${selectedActivityLevel ?? ''}');
      print('Goal: ${selectedGoal ?? ''}');
      print('Gender: ${selectedGender ?? ''}');

      final response = await http.patch(
        Uri.parse('$baseUrl/users/updateData'),
        body: jsonEncode({
          'name': name,
          'age': age,
          'height': height,
          'weight': weight,
          'activityLevel': selectedActivityLevel ?? '',
          'goal': selectedGoal ?? '',
          'gender': selectedGender ?? '',
        }),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': '*/*',
        },
      );
      print("state code of update user ${response.statusCode}");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['status'] == 'success') {
          // Update SharedPreferences with new values
          setState(() {
            prefs.setString('userName', name);
            prefs.setString('activityLevel', selectedActivityLevel ?? '');
            prefs.setString('gender', selectedGender ?? '');
            prefs.setString('goal', selectedGoal ?? '');
            prefs.setInt('height', height);
            prefs.setInt('age', age);
            prefs.setInt('weight', weight);
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Profile updated successfully! ${responseData['message']}',
              ),
            ),
          );
          navigateTo(
            context,
            const ProfilePage(),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Failed to update profile. ${responseData['message']}',
              ),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to update profile. Please try again later.'),
          ),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'An error occurred while updating profile. Please try again later.',
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    ageController.dispose();
    heightController.dispose();
    weightController.dispose();
    super.dispose();
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
                        height: MediaQuery.of(context).size.width * 0.04,
                      ),
                      Text(
                        'Update Your Profile',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: largeFotSize,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.04,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Form(
                          key: _formKey,
                          child: ListView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              const Text(
                                "user name",
                                style: TextStyle(fontSize: 12),
                              ),
                              const SizedBox(height: 10),
                              RoundedTextField(
                                controller: nameController,
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
                              const SizedBox(height: 25),
                              const Text(
                                "Weight",
                                style: TextStyle(fontSize: 12),
                              ),
                              const SizedBox(height: 10),
                              RoundedTextField(
                                keyboardType:
                                    const TextInputType.numberWithOptions(),
                                controller: weightController,
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
                              const SizedBox(height: 25),
                              const Text(
                                "Height",
                                style: TextStyle(fontSize: 12),
                              ),
                              const SizedBox(height: 10),
                              RoundedTextField(
                                keyboardType:
                                    const TextInputType.numberWithOptions(),
                                controller: heightController,
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
                              const SizedBox(height: 25),
                              const Text(
                                "Age",
                                style: TextStyle(fontSize: 12),
                              ),
                              const SizedBox(height: 10),
                              RoundedTextField(
                                keyboardType:
                                    const TextInputType.numberWithOptions(),
                                controller: ageController,
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
                              const SizedBox(height: 25),
                              const Text(
                                "Activity Level",
                                style: TextStyle(fontSize: 12),
                              ),
                              const SizedBox(height: 10),
                              DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 15),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  filled: true,
                                  fillColor: Ucolor.white,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      'assets/icons/activity_icon.png',
                                      width: 20,
                                      height: 20,
                                    ),
                                  ),
                                ),
                                value: selectedActivityLevel,
                                items: activityLevels.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedActivityLevel = newValue;
                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please select your activity level';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 25),
                              const Text(
                                "Goal",
                                style: TextStyle(fontSize: 12),
                              ),
                              const SizedBox(height: 10),
                              DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 15),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  filled: true,
                                  fillColor: Ucolor.white,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      'assets/icons/goal_icon.png',
                                      width: 20,
                                      height: 20,
                                    ),
                                  ),
                                ),
                                value: selectedGoal,
                                items: goals.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedGoal = newValue;
                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please select your goal';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 30),
                            ],
                          ),
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
                  stops: [0.0, 0.1],
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  RoundedButton(
                    width: double.maxFinite,
                    title: 'Update Profile',
                    onPressed: updateUserProfile,
                    backgroundColor: Ucolor.DarkGray,
                    textColor: Ucolor.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
