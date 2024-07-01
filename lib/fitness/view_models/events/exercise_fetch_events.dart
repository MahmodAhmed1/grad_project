//lib/fitness/view_models/events/exercise_fetch_events.dart
abstract class ExerciseEvent {}

class FetchExercises extends ExerciseEvent {
  final int dateID;

  FetchExercises(this.dateID);
}

class UpdateExerciseState extends ExerciseEvent {
  final int dateID;
  final String exerciseID;
  final bool isFinished;

  UpdateExerciseState(this.dateID, this.exerciseID, this.isFinished);
}

class ToggleChosenExercise extends ExerciseEvent {
  final String exerciseID;
  final bool isChosen;

  ToggleChosenExercise(this.exerciseID, this.isChosen);
}
