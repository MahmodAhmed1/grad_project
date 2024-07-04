import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:pyramend/on_boarding/on_boarding_view.dart';
import 'package:pyramend/shared/network/bloc_observer.dart';
import 'package:pyramend/shared/network/local/cache_helper.dart';
import 'package:pyramend/task_management/viewModel/cubit/task_cubit.dart';
import 'package:pyramend/water_intake/viewModel/water_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'authentication/views/log_in.dart';
import 'authentication/views/provider.dart';
import 'dashboard/views/home_page.dart';
import 'shared/styles/colors/colors.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const SimpleBlocObserver();
  CacheHelper.init();
  tz.initializeTimeZones(); // Initialize timezone data

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/launcher_icon');
  final InitializationSettings initializationSettings =
      const InitializationSettings(
    android: initializationSettingsAndroid,
  );

  flutterLocalNotificationsPlugin.initialize(initializationSettings);
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TaskCubit()..onDateSelected(DateTime.now()),
        ),
        BlocProvider(
          create: (context) => WaterCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'PyraMend',
        theme: ThemeData(
          primaryColor: Ucolor.primaryColor1,
          fontFamily: "Poppins",
        ),
        home: const AuthCheck(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class AuthCheck extends StatelessWidget {
  const AuthCheck({Key? key}) : super(key: key);

  Future<bool> checkLoginState(BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final userName = prefs.getString('userName');

      if (token != null && userName != null) {
        // Set the token and userName in the UserProvider
        Provider.of<UserProvider>(context, listen: false).token = token;
        Provider.of<UserProvider>(context, listen: false).userName = userName;
        print("Token and username found: $token, $userName");
        return true;
      }
      print("No token or username found");
      return false;
    } catch (e) {
      print("Error accessing SharedPreferences: $e");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: checkLoginState(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          print("Error in FutureBuilder: ${snapshot.error}");
          return const Center(child: Text("An error occurred"));
        } else {
          if (snapshot.data == true) {
            return const HomePage(); // Navigate to HomePage if logged in
          } else {
            return OnBoardingView(); // Navigate to onboarding if not logged in
          }
        }
      },
    );
  }
}
