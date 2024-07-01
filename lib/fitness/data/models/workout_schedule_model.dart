// import 'package:pyramend/fitness/data/models/exercise_model.dart';

// class WorkoutSchedule {
//   final Map<DateTime, List<Exercise>> schedule;

//   WorkoutSchedule({required this.schedule});

//   factory WorkoutSchedule.fromMap(Map<DateTime, List<Exercise>> map) {
//     return WorkoutSchedule(schedule: map);
//   }

//   Map<DateTime, List<Exercise>> toMap() {
//     return schedule;
//   }

  // Future<void> saveToDatabase() async {
  //   WorkoutDatabaseHelper helper = WorkoutDatabaseHelper.instance;
  //   Database db = await helper.database;
  //   await db.transaction((txn) async {
  //     for (var entry in schedule.entries) {
  //       await txn.insert(
  //         WorkoutDatabaseHelper.tableWorkouts,
  //         {
  //           WorkoutDatabaseHelper.columnDate: entry.key.toString(),
  //           WorkoutDatabaseHelper.columnExercises:
  //               _serializeExercises(entry.value),
  //         },
  //       );
  //     }
  //   });
  // }

  // static String _serializeExercises(List<Exercise> exercises) {
  //   // Serialize list of exercises to JSON
  //   return jsonEncode(exercises.map((e) => e.toMap()).toList());
  // }

  // static List<Exercise> _deserializeExercises(String serializedExercises) {
  //   // Deserialize JSON to list of exercises
  //   List<dynamic> decodedList = jsonDecode(serializedExercises);
  //   return decodedList.map((e) => Exercise.fromMap(e)).toList();
  // }

  // static Future<WorkoutSchedule> loadFromDatabase() async {
  //   try {
  //     WorkoutDatabaseHelper helper = WorkoutDatabaseHelper.instance;
  //     List<Map<String, dynamic>> workouts = await helper.getWorkouts();
  //     Map<DateTime, List<Exercise>> schedule = {};
  //     for (var workout in workouts) {
  //       DateTime date =
  //           DateTime.parse(workout[WorkoutDatabaseHelper.columnDate]);
  //       List<Exercise> exercises = _deserializeExercises(
  //           workout[WorkoutDatabaseHelper.columnExercises]);
  //       schedule[date] = exercises;
  //     }
  //     return WorkoutSchedule(schedule: schedule);
  //   } catch (e) {
  //     print('01-Error getting workout schedule: $e');
  //     return WorkoutSchedule(
  //         schedule: {}); // Return an empty schedule if an error occurs
  //   }
  // }
// }
