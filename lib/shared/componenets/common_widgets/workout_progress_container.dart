import 'package:flutter/material.dart';
import 'package:pyramend/shared/componenets/common_widgets/progress_bar.dart';
import 'package:pyramend/shared/componenets/common_widgets/workout_progress_header.dart';
import 'package:pyramend/shared/styles/colors/colors.dart';

class WorkoutProgressContainer extends StatelessWidget {
  const WorkoutProgressContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Adjust the padding and spacing dynamically
    final padding = screenWidth * 0.04;
    final spacing = screenWidth * 0.015;

    return Container(
      width: screenWidth * 0.9,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Ucolor.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          const WorkoutProgressHeader(),
          SizedBox(height: spacing),
          const ProgressBar(title: 'Chest', percentage: 0.7),
          SizedBox(height: spacing),
          const ProgressBar(title: 'Upper Leg', percentage: 0.99),
          SizedBox(height: spacing),
          const ProgressBar(title: 'Lower Leg', percentage: 1),
          SizedBox(height: spacing),
          const ProgressBar(title: 'Back', percentage: 0.3),
          SizedBox(height: spacing),
          const ProgressBar(title: 'Lower Arm', percentage: 0.85),
          SizedBox(height: spacing),
          const ProgressBar(title: 'Lower Arm', percentage: 0.32),
          SizedBox(height: spacing),
          const ProgressBar(title: 'Cardio', percentage: 0.66),
        ],
      ),
    );
  }
}
