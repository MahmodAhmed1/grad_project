import 'package:flutter/material.dart';
import 'package:pyramend/fitness/data/models/exercise_model.dart';
import 'package:pyramend/fitness/data/services/exercise_api_service.dart';
import 'package:pyramend/shared/componenets/common_widgets/buttons.dart';
import 'package:pyramend/shared/componenets/common_widgets/cupertino_picker.dart';
import 'package:pyramend/shared/componenets/constants/constants.dart';
import 'package:pyramend/shared/componenets/constants/enums.dart';

import 'package:pyramend/shared/styles/colors/colors.dart';

class ExerciseDetailsView extends StatefulWidget {
  final Exercise exercise;

  ExerciseDetailsView({Key? key, required this.exercise}) : super(key: key);

  @override
  _ExerciseDetailsViewState createState() => _ExerciseDetailsViewState();
}

class _ExerciseDetailsViewState extends State<ExerciseDetailsView> {
  late int sets;
  late int weight;
  late int repeats;
  bool _imageError = false;

  @override
  void initState() {
    super.initState();
    sets = widget.exercise.sets;
    weight = widget.exercise.weight;
    repeats = widget.exercise.repeats;
  }

  void _updateLocalExerciseDetails({
    int? newSets,
    int? newWeight,
    int? newRepeats,
  }) {
    setState(() {
      if (newSets != null) sets = newSets;
      if (newWeight != null) weight = newWeight;
      if (newRepeats != null) repeats = newRepeats;
    });
  }

  void _saveExerciseDetails() async {
    final updatedExercise = widget.exercise.copyWith(
      sets: sets,
      weight: weight,
      repeats: repeats,
    );

    try {
      await ExerciseService.updateExercise(updatedExercise.id, updatedExercise);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Exercise details updated successfully')),
      );

      // Navigate back to the previous screen after update
      Navigator.pop(context, updatedExercise);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update exercise details: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Ucolor.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
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
            expandedHeight: media.height * 0.25,
            flexibleSpace: FlexibleSpaceBar(
              background: _buildExerciseImage(media, widget.exercise),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  _buildExerciseTitle(
                    widget.exercise.name,
                    widget.exercise.bodyPart,
                    widget.exercise.secondaryMuscles,
                  ),
                  _buildExerciseInstructions(widget.exercise.instructions),
                  SizedBox(height: 10),
                  _buildExerciseEquipment(widget.exercise.equipment),
                  SizedBox(height: 10),
                  ItemPicker(
                    title: 'Sets',
                    step: 1,
                    maxValue: 20,
                    startingValue: sets,
                    onChanged: (value) {
                      _updateLocalExerciseDetails(newSets: value);
                    },
                  ),
                  ItemPicker(
                    title: 'Weight (kg)',
                    step: 1,
                    maxValue: 300,
                    startingValue: weight,
                    onChanged: (value) {
                      _updateLocalExerciseDetails(newWeight: value);
                    },
                  ),
                  ItemPicker(
                    title: 'Repetitions',
                    step: 1,
                    maxValue: 100,
                    startingValue: repeats,
                    onChanged: (value) {
                      _updateLocalExerciseDetails(newRepeats: value);
                    },
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: RoundedButton(
                      title: 'Done',
                      onPressed: _saveExerciseDetails,
                      gradient: Ucolor.fitnessGradient,
                      height: 60,
                      textColor: Ucolor.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseImage(Size media, Exercise exercise) {
    return Stack(
      children: [
        if (!_imageError)
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              exercise.gifUrl,
              width: media.width,
              height: media.height * 0.25,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                setState(() {
                  _imageError = true;
                });
                return Container(); // Return empty container on error
              },
            ),
          ),
        if (_imageError)
          Container(
            width: media.width,
            height: media.height * 0.25,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: Ucolor.fitnessGradient.scale(0.5),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.gif,
                  size: 70,
                  color: Ucolor.white,
                ),
                Text(
                  'Image not found!',
                  style: TextStyle(color: Ucolor.white),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildExerciseTitle(
      String title, String mainMuscle, List<String> secondaryMuscle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          capitalize(title),
          style: TextStyle(
            color: Ucolor.DarkGray,
            fontSize: headerLargeFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5),
        Text(
          '- Main Muscle: [${capitalize(mainMuscle)}]',
          style: TextStyle(
            color: Ucolor.gray,
            fontSize: bodySmallFontSize,
          ),
        ),
        Text(
          '- Secondary muscles: ${secondaryMuscle.join(", ")}',
          style: TextStyle(
            color: Ucolor.gray,
            fontSize: bodySmallFontSize,
          ),
        ),
      ],
    );
  }

  Widget _buildExerciseInstructions(List<String> instructions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 15),
        Text(
          'Instructions',
          style: TextStyle(
            color: Ucolor.gray,
            fontSize: headerSmallFontSize,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 5),
        for (String instruct in instructions)
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                gradient: Ucolor.fitnessGradient.scale(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                capitalize(instruct),
                style: TextStyle(
                  color: Ucolor.black,
                  fontSize: bodySmallFontSize,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildExerciseEquipment(String equipments) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 15),
        Text(
          'Exercise Equipment',
          style: TextStyle(
            color: Ucolor.gray,
            fontSize: headerSmallFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '- ${capitalize(equipments)}',
          style: TextStyle(
            color: Ucolor.black,
            fontSize: bodySmallFontSize,
          ),
        ),
      ],
    );
  }
}
