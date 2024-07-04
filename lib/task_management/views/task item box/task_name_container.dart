import 'package:flutter/material.dart';

class TaskNameContainer extends StatelessWidget {
  final Map<String, dynamic> task;

  const TaskNameContainer({required this.task, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print("Task Name Container"),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 200,
        ),
        child: Text(
          task["taskName"],
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 66, 66, 66),
          ),
        ),
      ),
    );
  }
}
