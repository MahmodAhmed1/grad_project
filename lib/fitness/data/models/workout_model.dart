class Workout {
  final List<String> exercises;
  final int date;

  Workout({
    required this.exercises,
    required this.date,
  });

  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
      exercises: List<String>.from(json['exercises']),
      date: json['date'],
    );
  }
}
