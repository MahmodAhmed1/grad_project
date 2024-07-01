import 'package:flutter/material.dart';
import 'package:pyramend/fitness/data/models/exercise_model.dart';
import 'package:pyramend/shared/componenets/common_widgets/buttons.dart';

import 'package:pyramend/shared/styles/colors/colors.dart';

class WorkoutListItem extends StatelessWidget {
  final Exercise exercise;
  final VoidCallback onTap;
  final VoidCallback onExerciseToggle;

  const WorkoutListItem({
    required this.exercise,
    required this.onTap,
    required this.onExerciseToggle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Display the checkbox based on exercise's isFinished status
          IconButton(
            onPressed: onExerciseToggle,
            icon: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: (exercise.isFinished)
                      ? Ucolor.fitnessPrimaryColor2
                      : Ucolor.gray,
                  width: 2.0,
                ),
              ),
              child: Center(
                child: (exercise.isFinished)
                    ? Container(
                        margin: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: Ucolor.fitnessGradient,
                        ),
                      )
                    : null,
              ),
            ),
          ),
          Expanded(
            child: RoundedButton(
              textColor: Ucolor.white,
              title: exercise.name,
              fontWeight: FontWeight.normal,
              height: 40,
              gradient: Ucolor.fitnessGradient,
              onPressed: onTap,
            ),
          ),
          Divider(
            thickness: 1,
          )
        ],
      ),
    );
  }
}
