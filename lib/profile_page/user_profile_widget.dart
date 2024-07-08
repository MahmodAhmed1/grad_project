import 'package:flutter/material.dart';
import 'package:pyramend/authentication/views/provider.dart';
import 'package:pyramend/shared/componenets/constants/constants.dart';
import 'package:pyramend/task_management/shared/components/components.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'edit_profile.dart';
import 'profile_detail_card.dart';
import 'profile_image.dart';
import 'profile_option.dart';
import 'profile_section.dart';
import 'package:pyramend/dashboard/views/home_page.dart';
import 'package:pyramend/fitness/views/daily_workouts.dart';
import 'package:pyramend/health/views/health.dart';
import 'package:pyramend/meals/views/meal_view.dart';
import 'package:pyramend/shared/componenets/common_widgets/nav_bar.dart';
import 'package:pyramend/task_management/views/todo_app_home.dart';
import 'package:pyramend/water_intake/views/water_intake.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userName = '';
  String activityLevel = '';
  String gender = '';
  String goal = '';
  String email = '';
  int height = 0;
  int age = 0;
  int weight = 0;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName') ?? '';
      activityLevel = prefs.getString('activityLevel') ?? '';
      gender = prefs.getString('gender') ?? '';
      goal = prefs.getString('goal') ?? '';
      email = prefs.getString('email') ?? '';
      height = prefs.getInt('height') ?? 0;
      age = prefs.getInt('age') ?? 0;
      weight = prefs.getInt('weight') ?? 0;
    });
  }

  double _calculateBMI() {
    if (height > 0 && weight > 0) {
      double heightInMeters = height / 100;
      return weight / (heightInMeters * heightInMeters);
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    double bmi = _calculateBMI();

    return Scaffold(
      appBar: AppBar(
          title: Text(
            'User Profile',
            style: TextStyle(
              color: Colors.black,
              fontSize: mediumFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ProfileImage(gender: gender),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        userName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      navigateTo(context, EditProfile());
                    },
                    icon: const Icon(Icons.edit),
                    color: Colors.grey,
                  ),
                ],
              ),
              sizedBoxHeight(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ProfileDetailCard(
                    label: "Height",
                    value: "${height}cm",
                  ),
                  ProfileDetailCard(
                    label: "Weight",
                    value: "${weight}kg",
                  ),
                  ProfileDetailCard(
                    label: "Age",
                    value: "$age",
                  ),
                ],
              ),
              sizedBoxHeight(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'BMI: ${bmi.toStringAsFixed(1)}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              sizedBoxHeight(10),
              ProfileSection(
                title: "Account",
                options: [
                  const ProfileOption(
                    destination: MealView(),
                    icon: 'assets/icons/meal_menu_icon.png',
                    label: "Track your Meals",
                  ),
                  ProfileOption(
                    destination: DailyWorkouts(),
                    icon: 'assets/icons/fitness_menu_icon.png',
                    label: "Workout Progress",
                  ),
                  ProfileOption(
                    destination: TodoAppHome(),
                    icon: 'assets/icons/task_menu_icon.png',
                    label: "Check your Tasks",
                  ),
                  const ProfileOption(
                    destination: WaterIntakeHome(),
                    icon: 'assets/icons/water_menu_icon.png',
                    label: "Track your Water Intake",
                  ),
                  const ProfileOption(
                    destination: HealthView(),
                    icon: 'assets/imgs/pills.png',
                    label: "Follow your Medications",
                  ),
                ],
              ),
              sizedBoxHeight(30),
              ProfileSection(
                title: "Other",
                options: [
                  ProfileOption(
                    destination: const HomePage(),
                    icon: Icons.mail_outline.codePoint.toString(),
                    label: "Contact Us",
                  ),
                  ProfileOption(
                    destination: const HomePage(),
                    icon: Icons.privacy_tip_outlined.codePoint.toString(),
                    label: "Privacy Policy",
                  ),
                  ProfileOption(
                    destination: const HomePage(),
                    icon: Icons.logout.codePoint.toString(),
                    label: "User Logout",
                    onTap: () {
                      Provider.of<UserProvider>(context, listen: false)
                          .clearLoginState(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const NavBarView(),
    );
  }

  SizedBox sizedBoxHeight(double height) {
    return SizedBox(height: height);
  }
}
