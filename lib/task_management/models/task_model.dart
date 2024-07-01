class Task {
  final String taskName;
  final String description;
  final String category;
  final String priority;
  final String state;
  final int duration;
  final String date;
  final String time;

  Task({
    required this.taskName,
    required this.description,
    required this.category,
    required this.priority,
    required this.state,
    required this.duration,
    required this.date,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'taskName': taskName,
      'description': description,
      'category': category,
      'priority': priority,
      'state': state,
      'duration': duration,
      'date': date,
      'time': time,
    };
  }

  static fromJson(item) {}
}
