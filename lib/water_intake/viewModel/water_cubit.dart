import 'package:flutter/material.dart';
import 'package:pyramend/water_intake/api/water_intake_api.dart';
import 'package:pyramend/water_intake/viewModel/water_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class WaterCubit extends Cubit<WaterStates> {
  WaterCubit() : super(AppInitialStates());

  static WaterCubit get(context) => BlocProvider.of(context);

  int recommendedWater = 0;
  int waterTarget = 3200;
  int remaining = 3200;
  int waterConsume = 0;
  String userName = "User Name";
  DateTime now = DateTime.now();
  void showSuccessToastFail(String msg) async {
    await Future.delayed(const Duration(milliseconds: 100));
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 10,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void showSuccessToastSuc(String msg) async {
    await Future.delayed(const Duration(milliseconds: 100));
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 5,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  double calculatePercentage() {
    // Ensure waterTarget and waterConsumed are not negative
    waterTarget = waterTarget >= 0 ? waterTarget : 0;
    var waterConsumed =
        waterConsume >= 0 && waterConsume <= waterTarget ? waterConsume : 0;
    // Calculate percentage
    double percentage = (waterConsumed / waterTarget) * 400;
    // Ensure percentage is between 0 and 100
    percentage = percentage.clamp(0, 400);
    return percentage;
  }

  void updateWaterTarget(int amount) {
    if (amount < 500 || amount > recommendedWater * 2) {
      showSuccessToastFail("Amount Water Target Not Suitable ⚠");
    } else {
      waterTarget = amount;
      fetchWaterIntakeData(inputTarget: waterTarget);
      addWaterConsumption(0);
      showSuccessToastSuc("Target Updated Successfully ✔");
    }
  }

  String getGreeting() {
    if (now.hour >= 5 && now.hour < 12) {
      return 'Morning';
    } else if (now.hour >= 12 && now.hour < 17) {
      return 'Afternoon';
    } else if (now.hour >= 17 && now.hour < 21) {
      return 'Evening';
    } else {
      return 'Night';
    }
  }

  double percentageOfWater() {
    double percentage = (waterConsume / waterTarget).abs();
    // print(percentage);
    // emit(AppPercentageOfWaterState());
    return percentage >= 1 ? 1 : (percentage >= 0 ? percentage : 0);
  }

  Future<void> fetchWaterIntakeData({int inputTarget = 0}) async {
    emit(AppLoadingState());
    try {
      // Simulate a delay for the API call
      await Future.delayed(const Duration(seconds: 2));

      // Assuming fetchWaterIntakeData returns Map<String, dynamic>
      Map<String, dynamic> waterIntakeData =
          await WaterIntakeApi().fetchWaterIntakeData(inputTarget);

      // Accessing the fields from the map
      recommendedWater = waterIntakeData['target'];
      waterTarget = waterIntakeData['inputTarget'];
      userName = waterIntakeData['userName'];
      print(userName);

      remaining = waterTarget - waterConsume;
      remaining < 0 ? remaining = 0 : remaining;
      // x = waterConsume;
      emit(AppDataLoadedState());
    } catch (e) {
      emit(AppErrorState());
    }
  }

  String getDashboardTarget() {
    double x = waterTarget / 1000;
    String formattedTarget;

    // Check if the decimal part is zero
    if (x == x.toInt()) {
      formattedTarget = "${x.toInt()} Liters";
    } else {
      formattedTarget =
          "${x.toStringAsFixed(3).replaceAll(RegExp(r'0*$'), '').replaceAll(RegExp(r'\.$'), '')} Liters";
    }

    return formattedTarget;
  }

  Future<void> addWaterConsumption(int amount) async {
    emit(AppLoadingState());
    try {
      print(amount);
      print(waterConsume + amount);
      if (amount < 0 && waterConsume + amount < 0) {
        amount = -waterConsume;
      }
      final response = await WaterIntakeApi().addWaterConsumption(amount);

      waterConsume = response['waterConsumed'];
      remaining = waterTarget - waterConsume;
      remaining < 0 ? remaining = 0 : remaining;
      String message = response['message'];
      print(response);
      emit(AppWaterConsumptionUpdatedState(message, remaining));
    } catch (e) {
      emit(AppErrorState());
    }
  }
}
