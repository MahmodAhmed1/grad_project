import 'package:flutter/material.dart';
import 'package:pyramend/fitness/data/models/exercise_model.dart';
import 'package:pyramend/fitness/views/exercises_view.dart';
import 'package:pyramend/shared/componenets/common_widgets/buttons.dart';
import 'package:pyramend/shared/componenets/constants/constants.dart';
import 'package:pyramend/shared/styles/colors/colors.dart';
import '../data/services/exercise_api_service.dart';

class WorkoutsView extends StatefulWidget {
  final int? dateID; // Nullable dateID
  WorkoutsView({
    Key? key,
    required this.dateID,
  }) : super(key: key);

  @override
  State<WorkoutsView> createState() => _WorkoutsViewState();
}

class _WorkoutsViewState extends State<WorkoutsView> {
  List<Exercise> exercises = [];

  bool showWarning = true;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    // final dateID =
    //     widget.dateID ?? 0; // Provide a default value if dateID is null

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Workouts',
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
        actions: [],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            showWarning
                ? _buildWarningContainer()
                : SizedBox(), // Show warning container if showWarning is true
            Text(
              "What do you want to train",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: mediumFontSize,
              ),
            ),
            SizedBox(height: 20),
            _buildWorkoutContainer(
                context, 'chest', 'assets/imgs/fitness/male_chest.jpeg', media),
            SizedBox(height: 10),
            _buildWorkoutContainer(context, 'lower Arm',
                'assets/imgs/fitness/female_arm.jpeg', media),
            SizedBox(height: 10),
            _buildWorkoutContainer(context, 'upper Arm',
                'assets/imgs/fitness/female_arm.jpeg', media),
            SizedBox(height: 10),
            _buildWorkoutContainer(context, 'cardio',
                'assets/imgs/fitness/female_cardio.jpeg', media),
            SizedBox(height: 10),
            _buildWorkoutContainer(
                context, 'back', 'assets/imgs/fitness/male_back.jpeg', media),
            SizedBox(height: 10),
            _buildWorkoutContainer(context, 'lower Legs',
                'assets/imgs/fitness/male_leg.jpeg', media),
            SizedBox(height: 10),
            _buildWorkoutContainer(context, 'upper Legs',
                'assets/imgs/fitness/male_leg.jpeg', media),
          ],
        ),
      ),
    );
  }

  Widget _buildWarningContainer() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(
          bottom: 10), // Add margin to separate from other widgets
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(Icons.warning, color: Colors.red),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              "Warning: These exercises should be performed by expert users or under the supervision of a fitness coach.",
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                showWarning =
                    false; // Set showWarning to false to hide the warning container
              });
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
            ),
            child: Text(
              'Remove',
              style: TextStyle(
                  color: Ucolor.DarkGray, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildWorkoutContainer(
    BuildContext context,
    String exerciseName,
    String img,
    Size media,
  ) {
    return Container(
      padding: EdgeInsets.all(10),
      width: media.width * 0.90,
      height: media.height * 0.18,
      decoration: BoxDecoration(
        gradient: Ucolor.fitnessGradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 7,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$exerciseName Exercises',
                  style: TextStyle(color: Ucolor.white),
                ),
                Text('No. of exercises | Total time',
                    style: TextStyle(color: Ucolor.white)),
                SizedBox(height: 10),
                RoundedButton(
                  title: 'View More',
                  titleSize: smallMediumFontSize,
                  onPressed: () async {
                    print('View More button pressed');
                    try {
                      List<Exercise> fetchedExercises =
                          await ExerciseService.fetchExercisesByBodyPart(
                              exerciseName.replaceAll(' ', ''));
                      setState(() {
                        exercises = fetchedExercises;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ExercisesView(
                            exercises: exercises,
                            image: img,
                            name: exerciseName,
                            dateID: widget
                                .dateID, // Use dateID instead of widget.dateID
                          ),
                        ),
                      );
                    } catch (error) {
                      print('Failed to fetch exercises: $error');
                    }
                  },
                  height: media.height * 0.05,
                  width: media.width * 0.2,
                  backgroundColor: Ucolor.white,
                  textColor: Ucolor.DarkGray,
                ),
              ],
            ),
          ),
          Container(
            width: 130,
            height: 130,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: Ucolor.fitnessGradient,
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: Image.asset(
                '$img',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
