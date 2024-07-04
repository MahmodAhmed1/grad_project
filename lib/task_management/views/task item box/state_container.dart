import 'package:flutter/material.dart';

class StateContainer extends StatelessWidget {
  final Map<String, dynamic> task;
  final dynamic cubit;

  const StateContainer({required this.task, required this.cubit, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print("State Container"),
      child: Container(
        height: 30,
        width: 120,
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 192, 192, 192),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: Center(
          child: Text(
            task['state'] == 'finished'
                ? 'Finished ✔'
                : task['state'] == 'late'
                    ? 'Late 🕔'
                    : 'In Progress',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
