import 'package:flutter/material.dart';
import 'package:pyramend/dashboard/views/task_management_status/task_box.dart';

class TaskListContainer extends StatelessWidget {
  final dynamic cubit;
  const TaskListContainer({required this.cubit, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (cubit.todayTasks.isEmpty)
          const Text(
            'No tasks for today',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          )
        else
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) => TaskItemContainer(
              task: cubit.todayTasks[index],
              cubit: cubit,
            ),
            itemCount:
                cubit.todayTasks.length > 3 ? 3 : cubit.todayTasks.length,
          ),
      ],
    );
  }
}
