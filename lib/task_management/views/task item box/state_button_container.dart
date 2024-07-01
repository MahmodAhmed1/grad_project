import 'package:flutter/material.dart';

class StateButtonContainer extends StatelessWidget {
  final Map<String, dynamic> task;
  final dynamic cubit;

  const StateButtonContainer(
      {required this.task, required this.cubit, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print("State Button Container"),
      child: IconButton(
        onPressed: () {
          task['state'] == 'finished'
              ? cubit.updateTask({
                  "taskName": task['taskName'],
                  "state": 'in-progress',
                })
              : cubit.updateTask({
                  "taskName": task['taskName'],
                  "state": 'finished',
                });
        },
        icon: Icon(
          task['state'] == 'finished'
              ? Icons.check_circle
              : Icons.circle_outlined,
          color: task['state'] == 'finished' ? Colors.green : Colors.grey,
          size: 32,
        ),
      ),
    );
  }
}
