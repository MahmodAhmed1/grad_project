// import 'dart:convert';

// import 'package:pyramend/fitness/data/models/exercise_model.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// class WorkoutDatabaseHelper {
//   static final _databaseName = 'workout_database.db';
//   static final _databaseVersion = 1;

//   static final tableWorkouts = 'workouts';
//   static final columnId = '_id';
//   static final columnDate = 'date';
//   static final columnExercises = 'exercises';

//   WorkoutDatabaseHelper._privateConstructor();
//   static final WorkoutDatabaseHelper instance =
//       WorkoutDatabaseHelper._privateConstructor();

//   static Database? _database;

//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDatabase();
//     return _database!;
//   }

//   Future<Database> _initDatabase() async {
//     final path = join(await getDatabasesPath(), _databaseName);
//     return await openDatabase(path,
//         version: _databaseVersion, onCreate: _onCreate);
//   }

//   Future<void> _onCreate(Database db, int version) async {
//     await db.execute('''
//       CREATE TABLE $tableWorkouts (
//         $columnId INTEGER PRIMARY KEY,
//         $columnDate TEXT NOT NULL,
//         $columnExercises TEXT NOT NULL
//       )
//       ''');
//   }

//   Future<int> insertWorkout(Map<String, dynamic> workout) async {
//     Database db = await instance.database;
//     return await db.insert(tableWorkouts, workout);
//   }

//   Future<List<Map<String, dynamic>>> getWorkouts() async {
//     try {
//       Database db = await instance.database;
//       return await db.query(tableWorkouts);
//     } catch (e) {
//       print('Error getting workouts: $e');
//       return []; // Return an empty list if an error occurs
//     }
//   }

//   Future<List<Exercise>> getExercisesForDate(DateTime date) async {
//     try {
//       Database db = await instance.database;
//       List<Map<String, dynamic>> workoutRows = await db.query(
//         tableWorkouts,
//         where: '$columnDate = ?',
//         whereArgs: [date.toString()],
//       );

//       List<Exercise> exercises = [];
//       for (var row in workoutRows) {
//         List<dynamic> exerciseJson = jsonDecode(row[columnExercises]);
//         exercises.addAll(exerciseJson.map((e) => Exercise.fromMap(e)).toList());
//       }
//       return exercises;
//     } catch (e) {
//       print('Error getting workout schedule: $e');
//       return [];
//     }
//   }

//   Future<void> insertDummyWorkouts() async {
//     // Define dummy workouts as a list of maps
//     final List<Map<String, dynamic>> dummyWorkouts = [
//       {
//         columnDate: DateTime.now().toString(),
//         columnExercises: jsonEncode([
//           Exercise(
//             id: 1,
//             name: 'Push-ups',
//             isFinished: false,
//             bodyPart: 'Upper Body',
//             equipment: 'None',
//             gifUrl: 'assets/imgs/exercises/pushups.gif',
//             target: 'Chest',
//             secondaryMuscles: ['Shoulders', 'Triceps'],
//             instructions: [
//               'Start in a plank position with your hands shoulder-width apart...',
//               'Lower your body until your chest nearly touches the floor...',
//               'Push yourself back up to the starting position...'
//             ],
//           ).toMap(),
//           Exercise(
//             id: 2,
//             name: 'Squats',
//             isFinished: false,
//             bodyPart: 'Lower Body',
//             equipment: 'None',
//             gifUrl: 'assets/imgs/exercises/squats.gif',
//             target: 'Legs',
//             secondaryMuscles: ['Glutes', 'Hamstrings'],
//             instructions: [
//               'Stand with your feet shoulder-width apart...',
//               'Lower your body as if you were sitting back in a chair...',
//               'Keep your chest up and your back straight...',
//               'Push through your heels to return to the starting position...'
//             ],
//           ).toMap(),
//         ]),
//       },
//       // Add more dummy workouts as needed
//     ];

//     try {
//       // Get reference to the database
//       Database db = await instance.database;

//       // Insert each dummy workout into the database
//       for (final workout in dummyWorkouts) {
//         await db.insert(tableWorkouts, workout);
//       }
//       print('Dummy workouts inserted successfully.');
//     } catch (e) {
//       print('Error inserting dummy workouts: $e');
//     }
//   }
// }
