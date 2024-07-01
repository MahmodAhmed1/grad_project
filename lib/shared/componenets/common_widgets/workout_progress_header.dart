import 'package:flutter/material.dart';
import 'package:pyramend/shared/styles/colors/colors.dart';

class WorkoutProgressHeader extends StatelessWidget {
  const WorkoutProgressHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final textFontSize = screenWidth * 0.04; // Adjust the text size
    final containerHeight = screenWidth * 0.06; // Adjust the container height
    final iconSize = screenWidth * 0.05; // Adjust the icon size
    final textPadding = screenWidth * 0.01; // Adjust the padding

    return Row(
      children: [
        Text(
          'Workout Progress',
          style: TextStyle(
            fontSize: textFontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
        Container(
          height: containerHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Ucolor.DarkGray,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: textPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Weekly',
                  style: TextStyle(
                    fontSize: textFontSize *
                        0.7, // Slightly smaller than the main text
                    fontWeight: FontWeight.w400,
                    color: Ucolor.white,
                  ),
                ),
                const SizedBox(width: 2),
                Icon(Icons.arrow_drop_down,
                    color: Ucolor.white, size: iconSize),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
