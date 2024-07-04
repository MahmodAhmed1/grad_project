import 'package:flutter/material.dart';
import 'package:pyramend/dashboard/views/home_page.dart';
import 'package:pyramend/fitness/views/daily_workouts.dart';
import 'package:pyramend/health/views/health.dart';
import 'package:pyramend/meals/views/meal_view.dart';
import 'package:pyramend/profile_page/edit_profile.dart';
import 'package:pyramend/profile_page/profile_detail_card.dart';
import 'package:pyramend/profile_page/profile_image.dart';
import 'package:pyramend/profile_page/profile_option.dart';
import 'package:pyramend/profile_page/profile_section.dart';
import 'package:pyramend/shared/componenets/common_widgets/nav_bar.dart';
import 'package:pyramend/task_management/shared/components/components.dart';
import 'package:pyramend/task_management/views/todo_app_home.dart';
import 'package:pyramend/water_intake/views/water_intake.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
          title: const Text(
            'User Profile',
            style: TextStyle(
              fontSize: 18,
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
                        "$userName",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      navigateTo(context, EditProfile());
                    },
                    child: const Text("edit"),
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
              const ProfileSection(
                title: "Other",
                options: [
                  ProfileOption(
                    destination: HomePage(),
                    icon: Icons.mail_outline,
                    label: "Contact Us",
                  ),
                  ProfileOption(
                    destination: HomePage(),
                    icon: Icons.privacy_tip_outlined,
                    label: "Privacy Policy",
                  ),
                  // ProfileOption(
                  //   destination: HomePage(),
                  //   icon: Icons.logout,
                  //   label: "User Logout",
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const NavBarView(),
    );
  }
}
