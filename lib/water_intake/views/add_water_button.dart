import 'package:flutter/material.dart';
import 'package:pyramend/task_management/shared/components/components.dart';
import 'package:pyramend/water_intake/viewModel/water_cubit.dart';
import 'package:pyramend/water_intake/views/water_amout_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../viewModel/water_states.dart';
import 'water_consumption_display.dart';
// import 'water_amount_button.dart';

class AddWaterButton extends StatelessWidget {
  const AddWaterButton({super.key});

  @override
  Widget build(BuildContext context) {
    WaterCubit cubit = WaterCubit.get(context);

    return BlocConsumer<WaterCubit, WaterStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Center(
          child: Container(
            width: 169,
            height: 63,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(255, 129, 233, 221),
                  Color.fromARGB(255, 142, 193, 245),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: MaterialButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return BlocBuilder<WaterCubit, WaterStates>(
                      builder: (context, state) {
                        return SizedBox(
                          height: 350,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                  color: Color.fromARGB(255, 142, 193, 245),
                                ),
                                height: 100,
                                child: Center(
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 16),
                                      Center(
                                        child: Container(
                                          height: 4,
                                          width: 80,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      const Text(
                                        'Add Water',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 28.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              sizedBoxHeight(16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: WaterConsumptionDisplay(
                                        text:
                                            'Water consumption ${cubit.waterConsume} ml',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              sizedBoxHeight(24),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  WaterAmountButton(
                                    imagePath: 'assets/imgs/cup_water.jpg',
                                    amount: 100,
                                    onAddPressed: () {
                                      cubit.addWaterConsumption(100);
                                    },
                                    onRemovePressed: () {
                                      cubit.addWaterConsumption(-100);
                                    },
                                  ),
                                  WaterAmountButton(
                                    imagePath: 'assets/imgs/small_bottle.png',
                                    amount: 250,
                                    onAddPressed: () {
                                      cubit.addWaterConsumption(250);
                                    },
                                    onRemovePressed: () {
                                      cubit.addWaterConsumption(-250);
                                    },
                                  ),
                                  WaterAmountButton(
                                    imagePath: 'assets/imgs/bottle_water.png',
                                    amount: 500,
                                    onAddPressed: () {
                                      cubit.addWaterConsumption(500);
                                    },
                                    onRemovePressed: () {
                                      cubit.addWaterConsumption(-500);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              },
              child: const Text(
                "Add Water",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
