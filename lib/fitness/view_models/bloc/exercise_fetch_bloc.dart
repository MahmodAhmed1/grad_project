// exercise_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:pyramend/fitness/data/models/exercise_model.dart';
import 'package:pyramend/fitness/data/models/workout_model.dart';
import 'package:pyramend/fitness/data/services/exercise_api_service.dart';
import 'package:pyramend/fitness/data/services/workout_api_service.dart';
import 'package:pyramend/fitness/view_models/events/exercise_fetch_events.dart';
import 'package:pyramend/fitness/view_models/states/exercise_fetch_states.dart';

class ExerciseBloc extends Bloc<ExerciseEvent, ExerciseFetchState> {
  final Map<int, Map<String, bool>> exerciseStateByDate = {};

  ExerciseBloc() : super(ExercisesLoading()) {
    on<FetchExercises>(_onFetchExercises);
    on<UpdateExerciseState>(_onUpdateExerciseState);
  }

  Future<void> _onFetchExercises(
      FetchExercises event, Emitter<ExerciseFetchState> emit) async {
    emit(ExercisesLoading());
    try {
      List<Workout> fetchedWorkouts =
          await WorkoutService.getWorkoutsForDate(event.dateID);
      List<String> exerciseIds = fetchedWorkouts
          .map((workout) => workout.exercises)
          .expand((exercises) => exercises)
          .toList();

      List<Exercise> fetchedExercises = [];
      for (String exerciseId in exerciseIds) {
        Exercise exercise = await ExerciseService.fetchExerciseById(exerciseId);
        if (exerciseStateByDate[event.dateID]?.containsKey(exercise.id) ??
            false) {
          exercise.isFinished =
              exerciseStateByDate[event.dateID]![exercise.id]!;
        }
        fetchedExercises.add(exercise);
      }

      emit(ExercisesLoaded(fetchedExercises));
    } catch (error) {
      emit(ExercisesError('Error fetching exercises: $error'));
    }
  }

  void _onUpdateExerciseState(
      UpdateExerciseState event, Emitter<ExerciseFetchState> emit) {
    exerciseStateByDate[event.dateID] ??= {};
    exerciseStateByDate[event.dateID]![event.exerciseID] = event.isFinished;

    if (state is ExercisesLoaded) {
      final loadedState = state as ExercisesLoaded;
      final updatedExercises = loadedState.exercises.map((exercise) {
        if (exercise.id == event.exerciseID) {
          return Exercise(
            id: exercise.id,
            name: exercise.name,
            bodyPart: exercise.bodyPart,
            gifUrl: exercise.gifUrl,
            isFinished: event.isFinished,
            sets: exercise.sets,
            repeats: exercise.repeats,
            weight: exercise.weight,
            equipment: exercise.equipment,
            target: exercise.target,
            secondaryMuscles: exercise.secondaryMuscles,
            instructions: exercise.instructions,
          );
        }
        return exercise;
      }).toList();

      emit(ExercisesLoaded(updatedExercises));
    }
  }
}
