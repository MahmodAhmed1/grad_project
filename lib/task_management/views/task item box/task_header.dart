import 'package:flutter/material.dart';
import 'package:pyramend/task_management/shared/components/components.dart';
import 'package:pyramend/task_management/views/task%20item%20box/duration_container.dart';
import 'package:pyramend/task_management/views/task%20item%20box/state_button_container.dart';
import 'package:pyramend/task_management/views/task%20item%20box/task_name_container.dart';

class TaskHeader extends StatelessWidget {
  final Map<String, dynamic> task;
  final dynamic cubit;

  const TaskHeader({required this.task, required this.cubit, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TaskNameContainer(task: task),
        sizedBoxWidth(20),
        Expanded(child: DurationContainer(cubit: cubit, task: task)),
        StateButtonContainer(cubit: cubit, task: task),
        //TimeContainer(task: task),
      ],
    );
  }
}
