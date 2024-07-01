// lib/fitness/view_models/events/exercise_details_events.dart

import 'package:pyramend/fitness/data/models/exercise_model.dart';

abstract class ExerciseDetailsEvent {}

class LoadExerciseDetailsEvent extends ExerciseDetailsEvent {
  final String exerciseId;
  LoadExerciseDetailsEvent(this.exerciseId);
}

class UpdateExerciseDetailsEvent extends ExerciseDetailsEvent {
  final Exercise updatedExercise;
  UpdateExerciseDetailsEvent(this.updatedExercise);
}
