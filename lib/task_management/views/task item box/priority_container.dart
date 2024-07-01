import 'package:flutter/material.dart';

class PriorityContainer extends StatelessWidget {
  final Map<String, dynamic> task;
  final dynamic cubit;

  const PriorityContainer({required this.task, required this.cubit, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print("priority Container"),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(
            color: const Color.fromARGB(181, 185, 185,
                185), // You can change the color to whatever you need
            width: 1.0, // Adjust the width of the border
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.flag_outlined,
              color: cubit.priorityColorList[task["priority"]],
              size: 18,
            ),
            const SizedBox(width: 5),
            Text(
              task["priority"] == "medium" ? "general" : task["priority"],
              style: TextStyle(
                color: cubit.priorityColorList[task["priority"]],
                // fontFamily: 'Playwrite México',
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
