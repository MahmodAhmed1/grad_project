import 'package:flutter/material.dart';
// import 'package:pyramend/fitness/views/fitness_view.dart';
import 'package:pyramend/dashboard/views/home_page.dart';
import 'package:pyramend/fitness/views/daily_workouts.dart';
import 'package:pyramend/health/views/health.dart';
import 'package:pyramend/meals/views/meal_view.dart';
import 'package:pyramend/profile_page/user_profile_widget.dart';
import 'package:pyramend/task_management/views/todo_app_home.dart';
import 'package:pyramend/water_intake/views/water_intake.dart';
import '../../styles/colors/colors.dart';

class NavBarView extends StatefulWidget {
  const NavBarView({super.key});

  @override
  State<NavBarView> createState() => _NavBarViewState();
}

class _NavBarViewState extends State<NavBarView> {
  int _selectedTab = 0;
  final tabs = [
    const HomePage(),
    const MealView(),
    DailyWorkouts(),
    const HealthView(),
    const WaterIntakeHome(),
    TodoAppHome(),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Ucolor.white,
        boxShadow: const [
          BoxShadow(
              color: Colors.black12, blurRadius: 2, offset: Offset(0, -2)),
        ],
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Ucolor.white,
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/home_menu_icon.png'),
            label: '',
            activeIcon: Image.asset('assets/icons/selected_home_menu_icon.png'),
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/meal_menu_icon.png'),
            label: '',
            activeIcon: Image.asset('assets/icons/selected_meal_menu_icon.png'),
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: 24,
              height: 24,
              child: Image.asset('assets/icons/fitness_menu_icon.png'),
            ),
            label: '',
            activeIcon:
                Image.asset('assets/icons/selected_fitness_menu_icon.png'),
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: 24,
              height: 24,
              child: Image.asset('assets/imgs/pills.png'),
            ),
            label: '',
            activeIcon: Image.asset('assets/icons/selected_task_menu_icon.png'),
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: 24,
              height: 24,
              child: Image.asset('assets/icons/water_menu_icon.png'),
            ),
            label: '',
            activeIcon: Image.asset('assets/icons/selected_task_menu_icon.png'),
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/task_menu_icon.png'),
            label: '',
            activeIcon: Image.asset('assets/icons/selected_task_menu_icon.png'),
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedTab = index;
          });
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return tabs[_selectedTab];
          }));
        },
      ),
    );
  }
}
