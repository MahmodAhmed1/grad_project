// lib/fitness/view_models/states/exercise_fetch_states.dart
import 'package:pyramend/fitness/data/models/exercise_model.dart';

abstract class ExerciseFetchState {}

class ExercisesLoading extends ExerciseFetchState {}

class ExercisesLoaded extends ExerciseFetchState {
  final List<Exercise> exercises;

  ExercisesLoaded(this.exercises);
}

class ExercisesError extends ExerciseFetchState {
  final String message;

  ExercisesError(this.message);
}
