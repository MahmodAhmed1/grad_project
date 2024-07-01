//lib/fitness/view_models/bloc/exercise_details_bloc.dart
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:pyramend/fitness/data/services/exercise_api_service.dart';

import 'package:pyramend/fitness/view_models/events/exercise_details_events.dart';
import 'package:pyramend/fitness/view_models/states/exercise_details_states.dart';

class ExerciseDetailsBloc
    extends Bloc<ExerciseDetailsEvent, ExerciseDetailsState> {
  ExerciseDetailsBloc() : super(ExerciseDetailsInitial()) {
    on<LoadExerciseDetailsEvent>(_onLoadExerciseDetails);
    on<UpdateExerciseDetailsEvent>(_onUpdateExerciseDetails);
  }

  Future<void> _onLoadExerciseDetails(LoadExerciseDetailsEvent event,
      Emitter<ExerciseDetailsState> emit) async {
    emit(ExerciseDetailsLoading());
    try {
      final exercise =
          await ExerciseService.fetchExerciseById(event.exerciseId);
      emit(ExerciseDetailsLoaded(exercise));
    } catch (error) {
      emit(ExerciseDetailsError('Failed to load exercise details: $error'));
    }
  }

  Future<void> _onUpdateExerciseDetails(UpdateExerciseDetailsEvent event,
      Emitter<ExerciseDetailsState> emit) async {
    emit(ExerciseDetailsLoading());
    try {
      final updatedExerciseFromServer = await ExerciseService.updateExercise(
        event.updatedExercise.id,
        event.updatedExercise,
      );
      emit(ExerciseDetailsLoaded(updatedExerciseFromServer));
    } catch (error) {
      emit(ExerciseDetailsError('Failed to update exercise details: $error'));
    }
  }
}
