import 'package:flutter/material.dart';
import 'package:pyramend/task_management/shared/components/components.dart';
import 'package:pyramend/task_management/views/edit_task.dart';
import 'package:pyramend/task_management/views/task%20item%20box/slidable_action.dart';
import 'package:pyramend/task_management/views/task%20item%20box/state_container.dart';
import 'package:pyramend/task_management/views/task%20item%20box/task_container.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TaskItem extends StatelessWidget {
  final Map<String, dynamic> task;
  final dynamic cubit;

  const TaskItem({required this.task, required this.cubit, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(task["_id"]),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: 0.5,
        children: [
          SlidableActionWidget(
            icon: Icons.edit,
            color: Colors.blueAccent,
            label: 'Edit',
            onPressed: () {
              navigateTo(context, UpdateTask(task: task));
            },
          ),
          SlidableActionWidget(
            icon: Icons.delete,
            color: Colors.redAccent,
            label: 'Delete',
            onPressed: () => cubit.deleteTask(taskName: task["taskName"]),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StateContainer(task: task, cubit: cubit),
            TaskContainer(task: task, cubit: cubit),
          ],
        ),
      ),
    );
  }
}
