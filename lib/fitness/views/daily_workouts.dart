import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import for date formatting
import 'package:pyramend/fitness/data/models/exercise_model.dart';
import 'package:pyramend/fitness/data/models/workout_model.dart';
import 'package:pyramend/fitness/data/services/exercise_api_service.dart';
import 'package:pyramend/fitness/data/services/workout_api_service.dart';
import 'package:pyramend/fitness/views/exercise_item.dart';
import 'package:pyramend/fitness/views/workouts_view.dart';
import 'package:pyramend/shared/componenets/common_widgets/circular_button.dart';
import 'package:pyramend/shared/componenets/common_widgets/daily_schedule.dart';
import 'package:pyramend/shared/componenets/constants/constants.dart';
import 'package:pyramend/shared/componenets/constants/enums.dart';

import 'package:pyramend/shared/styles/colors/colors.dart';
// import 'package:pyramend/task_management/views/daily_schedule.dart';

class DailyWorkouts extends StatefulWidget {
  @override
  State<DailyWorkouts> createState() => _DailyWorkoutsState();
}

class _DailyWorkoutsState extends State<DailyWorkouts> {
  int? selectedDate; // Nullable for initial state
  List<Exercise> exercises = []; // List to store fetched exercises
  Map<int, Map<String, bool>> exerciseStateByDate =
      {}; // Map to store exercise states by date

  @override
  void initState() {
    super.initState();
    // Initialize with today's date
    selectedDate = _todayDateID();
    // Fetch workouts for today's date
    _fetchWorkoutByDate(selectedDate!);
  }

  int _todayDateID() {
    // Get today's date in the format expected by your API or data service
    var now = DateTime.now();
    return int.parse(DateFormat('yyyyMMdd').format(now));
  }

  void onChecked(bool? value, Exercise exercise) {
    setState(() {
      if (value != null && selectedDate != null) {
        exercise.isFinished = value;
        // Update the state map for the selected date
        exerciseStateByDate[selectedDate!] ??= {};
        exerciseStateByDate[selectedDate!]![exercise.id] = value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Ucolor.white,
      appBar: AppBar(
        title: Text(
          'Daily Workout Schedule',
          style: TextStyle(
            color: Colors.black,
            fontSize: mediumFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Ucolor.white,
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            width: 40,
            height: 40,
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Ucolor.lightGray,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(
              'assets/icons/Back-Navs-Bttn.png',
              width: 15,
              height: 15,
              fit: BoxFit.contain,
            ),
          ),
        ),
        actions: [], // Add any action buttons here
      ),
      body: ListView(
        children: [
          DailySchedule(
            initialDate: selectedDate, // Pass initial selected date
            onDateSelected: (val) {
              setState(() {
                selectedDate = val;
                _fetchWorkoutByDate(
                    selectedDate!); // Fetch exercises when date is selected
              });
            },
          ),
          // Display fetched exercises if available
          exercises.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '<${capitalize(exercises[0].bodyPart)} Exercises>',
                      style: TextStyle(
                        color: Ucolor.gray,
                        fontSize: smallMediumFontSize,
                      ),
                    ),
                    _buildExerciseList(),
                  ],
                )
              : Center(
                  child: Column(
                    children: [
                      Image.asset('assets/imgs/fitness/checklist.png'),
                      Text(
                        'Please tap + button to add workout schedule',
                        style: TextStyle(color: Ucolor.gray),
                      )
                    ],
                  ),
                ),
        ],
      ),
      floatingActionButton: CircularButton(
        height: media.width * 0.18,
        width: media.width * 0.18,
        gradient: Ucolor.fitnessGradient,
        icon: Icon(
          Icons.add,
          color: Ucolor.white,
        ),
        ontap: selectedDate != null
            ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => WorkoutsView(
                      dateID: selectedDate!,
                    ),
                  ),
                );
              }
            : null,
      ),
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
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          var exercise = exercises[index];
          return ExerciseItem(
            key: ValueKey(exercise.id), // Ensure each item has a unique key
            exercise: exercise,
            onChecked: (value) => onChecked(value, exercise),
            isMarkDone: false,
            // Indicating this is for marking as done
          );
        },
      ),
    );
  }

  // Function to fetch exercises by date from the API
  void _fetchWorkoutByDate(int dateID) async {
    try {
      List<Workout> fetchedWorkouts =
          await WorkoutService.getWorkoutsForDate(dateID);

      List<String> exerciseIds = fetchedWorkouts
          .map((workout) => workout.exercises)
          .expand((exercises) => exercises)
          .toList();

      List<Exercise> fetchedExercises = [];
      for (String exerciseId in exerciseIds) {
        try {
          Exercise exercise =
              await ExerciseService.fetchExerciseById(exerciseId);
          // Restore the state from the map if it exists
          if (exerciseStateByDate[dateID]?.containsKey(exercise.id) ?? false) {
            exercise.isFinished = exerciseStateByDate[dateID]![exercise.id]!;
          }
          fetchedExercises.add(exercise);
        } catch (error) {
          print('Error fetching exercise with ID $exerciseId: $error');
        }
      }

      setState(() {
        exercises = fetchedExercises;
      });
      print(fetchedExercises);
    } catch (error) {
      // Handle error
      print('Error fetching exercises: $error');
    }
  }
}
