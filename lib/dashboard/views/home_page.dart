import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:provider/provider.dart';
import 'package:pyramend/dashboard/data/models/chart_spline_data.dart';
import 'package:pyramend/dashboard/views/task_management_status/dashboard_tasks.dart';
import 'package:pyramend/dashboard/views/water_status/activity_status_widget.dart';
import 'package:pyramend/health/views/health.dart';
import 'package:pyramend/profile_page/user_profile_widget.dart';
import 'package:pyramend/shared/componenets/common_widgets/chart_container.dart';
import 'package:pyramend/shared/componenets/common_widgets/circular_indicator.dart';
import 'package:pyramend/shared/componenets/common_widgets/nav_bar.dart';
import 'package:pyramend/shared/componenets/common_widgets/workout_progress_container.dart';
import 'package:pyramend/shared/styles/colors/colors.dart';
import 'package:pyramend/task_management/shared/components/components.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../authentication/views/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = '';
  int _steps = 0;
  late Stream<StepCount> _stepCountStream;
  late Future<Map<String, dynamic>> medicineFuture;
  int medicineCount = 0;
  int takenCount = 0;

  @override
  void initState() {
    super.initState();
    _loadUserData();

    _initPedometer();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName') ?? '';
      medicineFuture =
          Provider.of<UserProvider>(context, listen: false).getMedicine();
    });

    final medicineData = await medicineFuture;
    final data = medicineData['data'] ?? [];
    setState(() {
      medicineCount = data.length;
      takenCount = data.where((item) => item['taken'] == true).length;
    });
  }

  void _initPedometer() {
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(_onStepCount).onError(_onStepCountError);
  }

  void _onStepCount(StepCount event) {
    setState(() {
      _steps = event.steps;
    });
  }

  void _onStepCountError(error) {
    print('Pedometer Error: $error');
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Ucolor.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05, vertical: screenWidth * 0.09),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfilePage(),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Hello,',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            userName,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Ucolor.black,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Image.asset('assets/icons/profile_menu_icon.png',
                        width: 24, height: 24),
                  ],
                ),
              ),
              sizedBoxHeight(20),
              TasksDashboardContainer(),
              sizedBoxHeight(30),
              const Text(
                'Activity Status',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              sizedBoxHeight(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ActivityStatusWidget(),
                  // sizedBoxWidth(5),
                  Column(
                    children: [
                      CircularIndicator(
                        unit: 'steps',
                        goal: 10000,
                        value: 4402,
                        indicatorColor: Ucolor.DarkGray,
                        GradientBackgroundColor: Ucolor.fitnessPrimaryColors,
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      CircularIndicator(
                        unit: 'Calories',
                        goal: 2000,
                        value: 1450,
                        indicatorColor: Ucolor.DarkGray,
                        GradientBackgroundColor: Ucolor.mealsPrimaryGradient,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              const ChartContainer(),
              SizedBox(height: screenHeight * 0.05),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HealthView()));
                },
                child: Container(
                  margin: const EdgeInsets.fromLTRB(10, 0, 0, 39),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 28, 0),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3F6C8),
                            borderRadius: BorderRadius.circular(28),
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(24, 53, 0, 53),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 2),
                                    child: const Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'Your medicines\nfor today',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18,
                                          decoration: TextDecoration.none,
                                          height: 1.3,
                                          color: Color(0xFF0A0909),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Opacity(
                                      opacity: 0.6,
                                      child: Text(
                                        '$takenCount of $medicineCount done',
                                        style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15,
                                          height: 2.2,
                                          color: Color(0xFF000000),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 35,
                          right: -40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                      'assets/imgs/medicine_cover.png',
                                    ),
                                  ),
                                ),
                                child: Container(
                                  width: 208,
                                  height: 126,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // const WorkoutProgressContainer(),
              // SizedBox(height: screenHeight * 0.02),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const NavBarView(),
    );
  }
}

// Sample data
final List<ChartSplineData> chartData = <ChartSplineData>[
  ChartSplineData("Sun", 2),
  ChartSplineData("Mon", 4),
  ChartSplineData("Tue", 3),
  ChartSplineData("Wed", 8),
  ChartSplineData("Thu", 5),
  ChartSplineData("Fri", 7),
  ChartSplineData("Sat", 4),
];

final List<ChartSplineData> chartData2 = <ChartSplineData>[
  ChartSplineData("Sun", 5),
  ChartSplineData("Mon", 3),
  ChartSplineData("Tue", 7),
  ChartSplineData("Wed", 4),
  ChartSplineData("Thu", 5),
  ChartSplineData("Fri", 3),
  ChartSplineData("Sat", 2),
];
