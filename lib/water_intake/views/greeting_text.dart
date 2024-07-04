import 'package:flutter/material.dart';
import 'package:pyramend/water_intake/viewModel/water_cubit.dart';
import 'package:pyramend/water_intake/viewModel/water_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GreetingText extends StatelessWidget {
  const GreetingText({super.key});

  @override
  Widget build(BuildContext context) {
    WaterCubit cubit = WaterCubit.get(context);

    return BlocConsumer<WaterCubit, WaterStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Good ${cubit.getGreeting()},",
              style: const TextStyle(
                color: Color(0xFF046381),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "${cubit.userName}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      },
    );
  }
}
