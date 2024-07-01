import 'package:flutter/material.dart';
import 'package:pyramend/task_management/shared/components/components.dart';
import 'package:pyramend/water_intake/viewModel/water_cubit.dart';
import 'package:pyramend/water_intake/viewModel/water_states.dart';
import 'package:pyramend/water_intake/views/water_intake.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActivityStatusWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final WaterCubit cubit = BlocProvider.of<WaterCubit>(context);
    cubit.fetchWaterIntakeData();
    cubit.addWaterConsumption(0);
    return BlocConsumer<WaterCubit, WaterStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const WaterIntakeHome()),
              );
            },
            child: Container(
              height: 350,
              width: 190,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              decoration: BoxDecoration(
                color: const Color.fromARGB(202, 238, 238, 238),
                borderRadius: BorderRadius.circular(18.0),
              ),
              child: Row(
                children: [
                  WaterTubeContainer(cubit: cubit),
                  sizedBoxWidth(15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Water Intake",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      sizedBoxHeight(5),
                      Text(
                        cubit.getDashboardTarget(),
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 70, 70, 70)),
                      ),
                      sizedBoxHeight(10),
                      const Text(
                        "Proposed timing",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      sizedBoxHeight(8),
                      TimeAndAmountWidget(
                        amount: "${(cubit.waterTarget * 0.15).round()}ml",
                        time: "morning - 12pm",
                      ),
                      sizedBoxHeight(8),
                      TimeAndAmountWidget(
                        amount: "${(cubit.waterTarget * 0.30).round()}ml",
                        time: "1pm - 3pm",
                      ),
                      sizedBoxHeight(8),
                      TimeAndAmountWidget(
                        amount: "${(cubit.waterTarget * 0.30).round()}ml",
                        time: "4pm - 6pm",
                      ),
                      sizedBoxHeight(8),
                      TimeAndAmountWidget(
                        amount: "${(cubit.waterTarget * 0.15).round()}ml",
                        time: "7pm - 9pm",
                      ),
                      sizedBoxHeight(8),
                      TimeAndAmountWidget(
                        amount: "${(cubit.waterTarget * 0.10).round()}ml",
                        time: "10pm - night",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class WaterTubeContainer extends StatelessWidget {
  final dynamic cubit;

  const WaterTubeContainer({required this.cubit, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 30,
          height: 400,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 250, 250, 250),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            width: 30,
            height: cubit.calculatePercentage(),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(160, 33, 149, 243),
                  Color.fromARGB(255, 137, 117, 255),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class TimeAndAmountWidget extends StatelessWidget {
  final String time;
  final String amount;

  const TimeAndAmountWidget({
    Key? key,
    required this.time,
    required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 9, // Adjust as needed for your circle size
                height: 9, // Adjust as needed for your circle size
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(120, 33, 149, 243),
                ),
              ),
              sizedBoxWidth(5),
              Text(
                time,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          sizedBoxHeight(5),
          Row(
            children: [
              sizedBoxWidth(14),
              Text(
                amount,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(160, 33, 149, 243),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
