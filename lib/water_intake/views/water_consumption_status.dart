import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pyramend/water_intake/viewModel/water_cubit.dart';
import 'package:pyramend/water_intake/viewModel/water_states.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class WaterConsumptionStatus extends StatelessWidget {
  const WaterConsumptionStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final WaterCubit cubit = BlocProvider.of<WaterCubit>(context);

    return BlocConsumer<WaterCubit, WaterStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 200,
              height: 180,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/imgs/water.png',
                      width: double.infinity,
                      height: 120,
                    ),
                  ),
                  Center(
                    child: CircularPercentIndicator(
                      backgroundColor: const Color.fromARGB(255, 177, 220, 255),
                      radius: 90.0,
                      lineWidth: 10.0,
                      animation: true,
                      percent: cubit.percentageOfWater(),
                      center: Padding(
                        padding: const EdgeInsets.only(top: 110),
                        child: Text(
                          "${cubit.waterConsume}ml",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: Colors.blue[300],
                      animationDuration: 1200,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: 130,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    color: Colors.white,
                    child: InkWell(
                      onTap: () {
                        _showIntegerInputDialog(context, cubit);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Target 🥇",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Color(0xFF046381),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "${cubit.waterTarget}ml",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: 130,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Remaining 💪",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Color(0xFF046381),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "${cubit.remaining}ml",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _showIntegerInputDialog(BuildContext context, WaterCubit cubit) async {
    int? tempValue = cubit.waterTarget;

    final enteredValue = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter New Target'),
          content: TextField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(hintText: 'Enter target in ml'),
            onChanged: (value) {
              tempValue = int.tryParse(value);
            },
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                cubit.updateWaterTarget(
                    tempValue ?? 0); // Update cubit with new value
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
