import 'package:flutter/material.dart';
import 'package:pyramend/task_management/views/task%20item%20box/task_footer.dart';
import 'package:pyramend/task_management/views/task%20item%20box/task_header.dart';

class TaskContainer extends StatelessWidget {
  final Map<String, dynamic> task;
  final dynamic cubit;

  const TaskContainer({required this.task, required this.cubit, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10.0),
          bottomLeft: Radius.circular(10.0),
          bottomRight: Radius.circular(10.0),
        ),
        color: Color.fromARGB(199, 243, 243, 243),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      width: double.infinity,
      child: Column(
        children: [
          TaskHeader(task: task, cubit: cubit),
          const SizedBox(height: 5),
          TaskFooter(task: task, cubit: cubit),
        ],
      ),
    );
  }
}
