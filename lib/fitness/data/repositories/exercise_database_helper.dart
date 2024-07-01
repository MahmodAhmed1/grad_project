// import 'package:pyramend/fitness/data/models/exercise_model.dart';
// import 'package:pyramend/fitness/data/models/workout_model.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// class ExerciseDatabaseHelper {
//   static late Database _database;

//   Future<List<Exercise>> getExercisesForDate(DateTime date) async {
//     try {
//       final List<Map<String, dynamic>> workoutScheduleMaps =
//           await _database.query(
//         'workout_schedule',
//         where: 'date = ?',
//         whereArgs: [date.toIso8601String()],
//       );

//       if (workoutScheduleMaps.isEmpty) {
//         // If no workout schedule found for the selected date, return an empty list
//         return [];
//       }

//       // Extract exercises from the first workout schedule entry (assuming there's only one entry per date)
//       final List<dynamic> exerciseNames =
//           workoutScheduleMaps.first['exercises'].split(',');

//       // Fetch exercises from the 'exercises' table based on their names
//       final List<Exercise> exercises = [];
//       for (final name in exerciseNames) {
//         final List<Map<String, dynamic>> exerciseMaps = await _database
//             .query('exercises', where: 'name = ?', whereArgs: [name]);
//         if (exerciseMaps.isNotEmpty) {
//           final Exercise exercise = Exercise.fromMap(exerciseMaps.first);
//           exercises.add(exercise);
//         }
//       }

//       return exercises;
//     } catch (e) {
//       print('Error getting exercises for date: $e');
//       throw 'Error getting exercises for date';
//     }
//   }

//   static Future<void> initializeDatabase() async {
//     try {
//       _database = await openDatabase(
//         join(await getDatabasesPath(), 'pyramend.db'),
//         onCreate: (db, version) {
//           // Create exercises table
//           db.execute(
//             'CREATE TABLE exercises(id INTEGER PRIMARY KEY, name TEXT, isFinished INTEGER, bodyPart TEXT, equipment TEXT, gifUrl TEXT, target TEXT, secondaryMuscles TEXT, instructions TEXT)',
//           );
//           // Create workout_schedule table
//           db.execute(
//             'CREATE TABLE workout_schedule(date TEXT PRIMARY KEY, exercises TEXT)',
//           );
//         },
//         version: 1,
//       );
//     } catch (e) {
//       print('Error initializing database: $e');
//       throw 'Error initializing database';
//     }
//   }

//   Future<void> insertExercise(Exercise exercise) async {
//     try {
//       await _database.insert(
//         'exercises',
//         exercise.toMap(),
//         conflictAlgorithm: ConflictAlgorithm.replace,
//       );
//     } catch (e) {
//       print('Error inserting exercise: $e');
//       throw 'Error inserting exercise';
//     }
//   }

//   Future<List<Exercise>> getAllExercises() async {
//     try {
//       final List<Map<String, dynamic>> exerciseMaps =
//           await _database.query('exercises');
//       return exerciseMaps
//           .map((exerciseMap) => Exercise.fromMap(exerciseMap))
//           .toList();
//     } catch (e) {
//       print('Error getting all exercises: $e');
//       throw 'Error getting all exercises';
//     }
//   }

//   Future<void> insertWorkoutSchedule(
//       Map<DateTime, List<Exercise>> workoutSchedule) async {
//     try {
//       await _database.transaction((txn) async {
//         workoutSchedule.forEach((date, exercises) async {
//           await txn.insert(
//             'workout_schedule',
//             {
//               'date': date.toIso8601String(),
//               'exercises': exercises.map((e) => e.toMap()).toList().toString(),
//             },
//             conflictAlgorithm: ConflictAlgorithm.replace,
//           );
//         });
//       });
//     } catch (e) {
//       print('Error inserting workout schedule: $e');
//       throw 'Error inserting workout schedule';
//     }
//   }

//   Future<Map<DateTime, List<Exercise>>> getWorkoutSchedule() async {
//     try {
//       final List<Map<String, dynamic>> workoutScheduleMaps =
//           await _database.query('workout_schedule');
//       Map<DateTime, List<Exercise>> workoutSchedule = {};
//       for (var map in workoutScheduleMaps) {
//         DateTime date = DateTime.parse(map['date']);
//         List<int> exerciseIds = (map['exercises'] as String)
//             .split(',')
//             .map((e) => int.tryParse(e))
//             .where((id) => id != null)
//             .cast<int>()
//             .toList();
//         List<Exercise> exercises = await getExercisesByIds(exerciseIds);
//         workoutSchedule[date] = exercises;
//       }
//       return workoutSchedule;
//     } catch (e) {
//       print('Error getting workout schedule: $e');
//       return {}; // Return an empty map if an error occurs
//     }
//   }

//   Future<List<Exercise>> getExercisesByIds(List<int> ids) async {
//     try {
//       final List<Map<String, dynamic>> exerciseMaps = await _database.query(
//         'exercises',
//         where: 'id IN (${ids.join(',')})',
//       );
//       return exerciseMaps.map((map) => Exercise.fromMap(map)).toList();
//     } catch (e) {
//       print('Error getting exercises by IDs: $e');
//       throw 'Error getting exercises by IDs';
//     }
//   }

//   Future<void> insertWorkout(Workout workout) async {
//     try {
//       await _database.insert(
//         'workouts',
//         workout.toMap(),
//         conflictAlgorithm: ConflictAlgorithm.replace,
//       );
//     } catch (e) {
//       print('Error inserting workout: $e');
//       throw 'Error inserting workout';
//     }
//   }

//   // Additional methods for updating and deleting exercises, if needed
// }
