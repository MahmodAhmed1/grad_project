// import 'package:pyramend/fitness/data/models/exercise_model.dart';
// import 'package:pyramend/fitness/view_models/cubit/exercise_state.dart';
// import 'package:bloc/bloc.dart';

// // Define Cubit
// class ExerciseCubit extends Cubit<ExerciseState> {
//   ExerciseCubit(List<Exercise> exercises) : super(ExerciseState(exercises));

//   // Method to set the list of exercises
//   void setExercises(List<Exercise> exercises) {
//     emit(ExerciseState(exercises));
//   }

//   // Handle events
//   void toggleExerciseFinished(Exercise exercise) {
//     final List<Exercise> updatedExercises = state.exercises.map((e) {
//       if (e.name == exercise.name) {
//         return Exercise(name: e.name, isFinished: !e.isFinished);
//       } else {
//         return e;
//       }
//     }).toList();

//     emit(ExerciseState(updatedExercises));
//   }
// }
