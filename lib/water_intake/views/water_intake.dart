import 'package:flutter/material.dart';
import 'package:pyramend/shared/componenets/constants/constants.dart';
import 'package:pyramend/task_management/shared/components/components.dart';
import 'package:pyramend/task_management/shared/constants/icons.dart';
import 'package:pyramend/water_intake/views/add_water_button.dart';
import 'package:pyramend/water_intake/views/greeting_text.dart';
import 'package:pyramend/water_intake/views/water_consumption_status.dart';
import 'package:pyramend/water_intake/views/water_recommendation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pyramend/water_intake/viewModel/water_cubit.dart';
import 'package:pyramend/water_intake/viewModel/water_states.dart';

class WaterIntakeHome extends StatelessWidget {
  const WaterIntakeHome({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WaterCubit, WaterStates>(
      listener: (context, state) {},
      builder: (context, state) {
        WaterCubit cubit = WaterCubit.get(context);

        if (state is AppInitialStates) {
          cubit.fetchWaterIntakeData();
          cubit.addWaterConsumption(0);
        }

        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(172, 224, 239, 250),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: arrowBackIcon,
            ),
            title: Text(
              "Water Intake",
              style: TextStyle(
                color: Colors.black,
                fontSize: mediumFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          body: state is AppLoadingState
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  color: const Color.fromARGB(172, 224, 239, 250),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const GreetingText(),
                          const SizedBox(height: 20),
                          const WaterRecommendation(),
                          const SizedBox(height: 50),
                          const WaterConsumptionStatus(),
                          const SizedBox(height: 100),
                          const AddWaterButton(),
                          const SizedBox(height: 50),
                          Center(
                            child: Text(
                              "You've reached ${((cubit.waterConsume / cubit.waterTarget) * 100).round()}% of today’s goal, keep",
                              style: const TextStyle(
                                color: Color.fromARGB(255, 94, 94, 94),
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Center(
                            child: Text(
                              "hydrating and stay on track!",
                              style: TextStyle(
                                color: Color.fromARGB(255, 94, 94, 94),
                              ),
                            ),
                          ),
                          sizedBoxHeight(50),
                        ],
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
