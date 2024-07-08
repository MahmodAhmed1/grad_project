import 'package:flutter/material.dart';
import 'package:pyramend/water_intake/viewModel/water_cubit.dart';
import 'package:pyramend/water_intake/viewModel/water_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WaterRecommendation extends StatelessWidget {
  const WaterRecommendation({super.key});

  @override
  Widget build(BuildContext context) {
    WaterCubit cubit = WaterCubit.get(context);

    return BlocConsumer<WaterCubit, WaterStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: 210,
                padding: const EdgeInsets.all(10),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        "Water Recommended 🏆",
                        style: TextStyle(
                          color: Color(0xFF046381),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Center(
                      child: Text(
                        "${(cubit.recommendedWater / 1000).toStringAsFixed(1)} Liter",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                width: 200,
                height: 120,
                child: Image.asset(
                  'assets/imgs/cups.png',
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
