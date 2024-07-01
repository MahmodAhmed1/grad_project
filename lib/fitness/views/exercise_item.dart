//lib/fitness/views/exercise_item.dart
import 'package:flutter/material.dart';
import 'package:pyramend/fitness/data/models/exercise_model.dart';
import 'package:pyramend/fitness/views/exercise_details_view.dart';
import 'package:pyramend/shared/componenets/constants/constants.dart';
import 'package:pyramend/shared/componenets/constants/enums.dart';
import 'package:pyramend/shared/styles/colors/colors.dart';

class ExerciseItem extends StatelessWidget {
  final Exercise exercise;
  final ValueChanged<bool?> onChecked;
  final bool isMarkDone;

  const ExerciseItem({
    required this.exercise,
    required this.onChecked,
    this.isMarkDone = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
      child: InkWell(
        onTap: () {
          // Navigate to exercise details screen
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (BuildContext context) =>
                  ExerciseDetails(exercise: exercise),
            ),
          );
        },
        child: Container(
          height: MediaQuery.of(context).size.width /
              7, // Adjust the height according to your design
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            gradient: Ucolor.fitnessGradient.scale(0.2),
          ),
          child: Row(
            children: [
              // Exercise image
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  exercise.gifUrl,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    return Icon(Icons.image_outlined);
                  },
                ),
              ),
              // Exercise name and checkbox
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        capitalize(exercise.name),
                        style: TextStyle(
                          fontSize: headerSmallMediumFontSize,
                          fontWeight: FontWeight.w500,
                          color: Ucolor.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 4),
                    Checkbox(
                      value:
                          isMarkDone ? exercise.isFinished : exercise.ischosen,
                      onChanged: onChecked,
                      activeColor: Ucolor.black,
                      checkColor: Ucolor.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
