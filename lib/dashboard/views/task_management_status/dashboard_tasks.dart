import 'package:flutter/material.dart';
import 'package:pyramend/dashboard/views/task_management_status/task_list.dart';
// import 'package:pyramend/My_Dashboard/task_management_status/task_list.dart';
import 'package:pyramend/task_management/shared/components/components.dart';
import 'package:pyramend/task_management/viewModel/cubit/task_cubit.dart';
import 'package:pyramend/task_management/viewModel/cubit/task_states.dart';
import 'package:pyramend/task_management/views/todo_app_home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TasksDashboardContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TaskCubit cubit = TaskCubit.get(context);
    final today = DateTime.now();
    final formattedDate = DateFormat('yyyy-MM-dd').format(today);
    cubit.fetchTasksByFilter({"date": formattedDate});
    cubit.fetchTasksToday();

    return BlocConsumer<TaskCubit, TaskStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Container(
            child: Column(
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "Today Tasks",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        navigateTo(context, TodoAppHome());
                      },
                      child: const Row(
                        children: [
                          Text(
                            "see more",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          Icon(
                            Icons.chevron_right_outlined,
                            size: 16,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TaskListContainer(cubit: cubit),
              ],
            ),
          );
        });
  }
}
