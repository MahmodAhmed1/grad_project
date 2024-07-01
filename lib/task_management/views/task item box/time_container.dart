import 'package:flutter/material.dart';

class TimeContainer extends StatelessWidget {
  final Map<String, dynamic> task;

  const TimeContainer({required this.task, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print("Time Container"),
      child: Text(
        task["time"],
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 14,
          color: Color.fromARGB(255, 99, 99, 99),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
