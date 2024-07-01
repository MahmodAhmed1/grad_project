//lib/fitness/view_models/states/exercise_details_states.dart
import 'package:equatable/equatable.dart';
import 'package:pyramend/fitness/data/models/exercise_model.dart';

abstract class ExerciseDetailsState extends Equatable {
  const ExerciseDetailsState();

  @override
  List<Object?> get props => [];
}

class ExerciseDetailsInitial extends ExerciseDetailsState {}

class ExerciseDetailsLoading extends ExerciseDetailsState {}

class ExerciseDetailsLoaded extends ExerciseDetailsState {
  final Exercise exercise;

  ExerciseDetailsLoaded(this.exercise);

  @override
  List<Object?> get props => [exercise];
}

class ExerciseDetailsError extends ExerciseDetailsState {
  final String message;

  ExerciseDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}
