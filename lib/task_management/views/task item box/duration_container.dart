import 'package:flutter/material.dart';
import 'package:pyramend/task_management/shared/components/components.dart';
import 'package:pyramend/task_management/views/focus_mode.dart';

class DurationContainer extends StatelessWidget {
  final Map<String, dynamic> task;
  final dynamic cubit;

  const DurationContainer({required this.task, required this.cubit, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("Duration Container");
        navigateTo(context, FocusMode(initialMinutes: task['duration']));
      },
      child: Row(
        children: [
          const Icon(
            Icons.timer_outlined,
            size: 18,
          ),
          const SizedBox(width: 5),
          Text(
            "${task['duration']} min",
            style: const TextStyle(
              color: Color.fromARGB(255, 92, 92, 92),
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
