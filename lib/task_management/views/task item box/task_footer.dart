import 'package:flutter/material.dart';
import 'package:pyramend/task_management/shared/components/components.dart';
import 'package:pyramend/task_management/views/task%20item%20box/category_container.dart';
import 'package:pyramend/task_management/views/task%20item%20box/priority_container.dart';
import 'package:pyramend/task_management/views/task%20item%20box/time_container.dart';

class TaskFooter extends StatelessWidget {
  final Map<String, dynamic> task;
  final dynamic cubit;

  const TaskFooter({required this.task, required this.cubit, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: TimeContainer(task: task)),
        CategoryContainer(task: task, cubit: cubit),
        sizedBoxWidth(10),
        PriorityContainer(task: task, cubit: cubit),
      ],
    );
  }
}
