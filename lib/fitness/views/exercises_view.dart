import 'package:flutter/material.dart';
import 'package:pyramend/fitness/data/models/exercise_model.dart';
import 'package:pyramend/fitness/data/services/workout_api_service.dart';
import 'package:pyramend/fitness/views/daily_workouts.dart';
import 'package:pyramend/fitness/views/exercise_item.dart';
import 'package:pyramend/shared/componenets/common_widgets/buttons.dart';
import 'package:pyramend/shared/componenets/constants/constants.dart';

import 'package:pyramend/shared/styles/colors/colors.dart';

class ExercisesView extends StatefulWidget {
  final List<Exercise> exercises;
  final String image;
  final String name;
  final int? dateID;

  const ExercisesView({
    Key? key,
    required this.exercises,
    required this.image,
    required this.name,
    this.dateID,
  }) : super(key: key);

  @override
  _ExercisesViewState createState() => _ExercisesViewState();
}

class _ExercisesViewState extends State<ExercisesView> {
  List<Exercise> checkedExercises = [];

  void onChecked(bool? value, Exercise exercise) {
    setState(() {
      exercise.ischosen = value ?? false;
      if (exercise.ischosen) {
        if (!checkedExercises.contains(exercise)) {
          checkedExercises.add(exercise);
        }
      } else {
        checkedExercises.remove(exercise);
      }
    });
  }

  void onBtnPressed() {
    if (checkedExercises.isNotEmpty && widget.dateID != null) {
      List<String> checkedExerciseIds =
          checkedExercises.map((exercise) => exercise.id).toList();
      int dateID = widget.dateID!;

      // Call your API service to send the data
      WorkoutService.addWorkout(checkedExerciseIds, dateID);

      // Optionally, you can navigate to another screen or show a success message here
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => DailyWorkouts(),
        ),
      );
    } else {
      // Handle case when no exercises are checked or dateID is null
      // For example, show a snackbar or a toast message to inform the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Please select at least one exercise and provide a valid date ID.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    // final isPortrait = media.height > media.width;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor:
            Colors.transparent, // Set app bar background to transparent
        elevation: 0, // Remove app bar elevation
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            padding: EdgeInsets.all(10),
            child: Image.asset(
              'assets/icons/Back-Navs-Bttn.png',
              width: 15,
              height: 15,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          _buildBackgroundImage(media),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildExerciseList(),
                ],
              ),
            ),
          ),
          _buildAddToScheduleButton(),
        ],
      ),
    );
  }

  Widget _buildBackgroundImage(Size media) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Container(
          width: double.infinity,
          height: media.width * 0.8,
          decoration: BoxDecoration(
            gradient: Ucolor.fitnessGradient,
            image: DecorationImage(
              image: AssetImage(widget.image),
              fit: BoxFit.cover,
              onError: (exception, stackTrace) {
                // Handle image loading errors
              },
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: media.width * 0.8,
          color: Ucolor.black.withOpacity(0.5),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            widget.name.toUpperCase() + " EXERCISES",
            style: TextStyle(
              color: Ucolor.white,
              fontSize: headerLargeFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildExerciseList() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Ucolor.white,
      ),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: widget.exercises.length,
        itemBuilder: (context, index) {
          final exercise = widget.exercises[index];
          return ExerciseItem(
            exercise: exercise,
            onChecked: (value) => onChecked(value, exercise),
          );
        },
      ),
    );
  }

  Widget _buildAddToScheduleButton() {
    return Container(
      color: Ucolor.white,
      child: RoundedButton(
        textColor: Ucolor.white,
        title: 'Add to Schedule',
        width: 180,
        height: 55,
        gradient: Ucolor.fitnessGradient,
        onPressed: checkedExercises.isNotEmpty
            ? onBtnPressed
            : () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Please select at least one exercise.'),
                  ),
                );
              },
      ),
    );
  }
}
