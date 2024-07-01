//lib/fitness/views/exercise_details_view.dart
import 'package:flutter/material.dart';
import 'package:pyramend/fitness/data/models/exercise_model.dart';
import 'package:pyramend/fitness/view_models/bloc/exercise_details_bloc.dart';
import 'package:pyramend/fitness/view_models/events/exercise_details_events.dart';
import 'package:pyramend/fitness/view_models/states/exercise_details_states.dart';
import 'package:pyramend/shared/componenets/common_widgets/buttons.dart';
import 'package:pyramend/shared/componenets/common_widgets/cupertino_picker.dart';
import 'package:pyramend/shared/componenets/constants/constants.dart';
import 'package:pyramend/shared/componenets/constants/enums.dart';
import 'package:pyramend/shared/styles/colors/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExerciseDetails extends StatelessWidget {
  final Exercise exercise;
  const ExerciseDetails({Key? key, required this.exercise}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ExerciseDetailsBloc()..add(LoadExerciseDetailsEvent(exercise.id)),
      child: ExerciseDetailsView(exercise: exercise),
    );
  }
}

class ExerciseDetailsView extends StatefulWidget {
  final Exercise exercise;
  const ExerciseDetailsView({Key? key, required this.exercise})
      : super(key: key);

  @override
  _ExerciseDetailsViewState createState() => _ExerciseDetailsViewState();
}

class _ExerciseDetailsViewState extends State<ExerciseDetailsView> {
  late int sets;
  late int weight;
  late int repeats;

  @override
  void initState() {
    super.initState();
    sets = widget.exercise.sets;
    weight = widget.exercise.weight;
    repeats = widget.exercise.repeats;
  }

  void _updateExerciseDetails(BuildContext context, Exercise updatedExercise) {
    setState(() {
      sets = updatedExercise.sets;
      weight = updatedExercise.weight;
      repeats = updatedExercise.repeats;
    });
    BlocProvider.of<ExerciseDetailsBloc>(context)
        .add(UpdateExerciseDetailsEvent(updatedExercise));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Ucolor.white,
      appBar: AppBar(
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
      body: BlocBuilder<ExerciseDetailsBloc, ExerciseDetailsState>(
        builder: (context, state) {
          if (state is ExerciseDetailsLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ExerciseDetailsLoaded) {
            return LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildExerciseImage(constraints, state.exercise),
                      SizedBox(height: 10),
                      _buildExerciseTitle(
                        state.exercise.name,
                        state.exercise.bodyPart,
                        state.exercise.secondaryMuscles,
                      ),
                      _buildExerciseInstructions(state.exercise.instructions),
                      SizedBox(height: 10),
                      _buildExerciseEquipment(state.exercise.equipment),
                      SizedBox(height: 10),
                      ItemPicker(
                        title: 'Sets',
                        step: 1,
                        maxValue: 20,
                        startingValue: sets,
                        onChanged: (value) {
                          _updateExerciseDetails(
                              context, state.exercise.copyWith(sets: value));
                        },
                      ),
                      ItemPicker(
                        title: 'Weight (kg)',
                        step: 1,
                        maxValue: 300,
                        startingValue: weight,
                        onChanged: (value) {
                          _updateExerciseDetails(
                              context, state.exercise.copyWith(weight: value));
                        },
                      ),
                      ItemPicker(
                        title: 'Repetitions',
                        step: 1,
                        maxValue: 100,
                        startingValue: repeats,
                        onChanged: (value) {
                          _updateExerciseDetails(
                              context, state.exercise.copyWith(repeats: value));
                        },
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: RoundedButton(
                          title: 'Done',
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          gradient: Ucolor.fitnessGradient,
                          height: 60,
                          textColor: Ucolor.white,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is ExerciseDetailsError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return Center(child: Text('Unknown state'));
          }
        },
      ),
    );
  }

  Widget _buildExerciseImage(BoxConstraints constraints, Exercise exercise) {
    return Stack(
      children: [
        Image.network(
          exercise.gifUrl,
          width: constraints.maxWidth,
          height: constraints.maxHeight * 0.25,
          fit: BoxFit.contain,
          errorBuilder:
              (BuildContext context, Object exception, StackTrace? stackTrace) {
            return Stack(alignment: Alignment.center, children: [
              Container(
                width: constraints.maxWidth,
                height: constraints.maxHeight * 0.25,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: Ucolor.fitnessGradient.scale(0.5)),
              ),
              Container(
                width: constraints.maxWidth,
                height: constraints.maxHeight * 0.25,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Ucolor.black.withOpacity(0.3)),
              ),
              Column(
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
            ]);
          },
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
          '${capitalize(title)}',
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
          '- Secondary muscles: ${secondaryMuscle}',
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
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                '${capitalize(instruct)}',
                style: TextStyle(
                    color: Ucolor.black,
                    fontSize: bodySmallFontSize,
                    fontWeight: FontWeight.w500),
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
          'Exercise Equipments',
          style: TextStyle(
            color: Ucolor.gray,
            fontSize: headerSmallFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text('-${capitalize(equipments)}',
            style: TextStyle(color: Ucolor.black, fontSize: bodySmallFontSize))
      ],
    );
  }
}
