import 'package:flutter/material.dart';
import 'package:pyramend/shared/componenets/constants/constants.dart';
import 'package:pyramend/task_management/views/archive_todo_app.dart';
import 'package:pyramend/task_management/views/daily_schedule.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'package:pyramend/task_management/viewModel/cubit/task_cubit.dart';
import 'package:pyramend/task_management/viewModel/cubit/task_states.dart';

import 'package:pyramend/task_management/views/add_new_task_page.dart';
import 'package:pyramend/task_management/views/done_todo_app.dart';
import 'package:pyramend/task_management/views/focus_mode.dart';
import 'package:pyramend/task_management/views/new_todo_app.dart';

import 'package:pyramend/task_management/shared/components/components.dart';
import 'package:pyramend/task_management/shared/constants/colors.dart';
import '../shared/constants/icons.dart';

// ignore: must_be_immutable
class TodoAppHome extends StatelessWidget {
  TodoAppHome({Key? key}) : super(key: key);
  bool isAddPage = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskCubit, TaskStates>(
      listener: (context, state) {},
      builder: (BuildContext context, state) {
        TaskCubit cubit = TaskCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: arrowBackIcon,
            ),
            title: Text(
              "To-Do",
              style: TextStyle(
                color: Colors.black,
                fontSize: mediumFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              PopupMenuButton<String>(
                icon: threeDotsIcon,
                onSelected: (value) {},
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: 'Option 1',
                    child: TextButton(
                      child: const Text(
                        "Completed tasks",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context, 'Option 1');
                        cubit.fetchTasksByFilter({"state": "finished"});
                        navigateTo(context, const DoneTasks());
                      },
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'Option 2',
                    child: TextButton(
                      child: const Text(
                        "All My tasks",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context, 'Option 2');
                        navigateTo(context, const AllTasksAppScreen());
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 5),
            ],
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                // sizedBoxHeight(12),
                SizedBox(
                  height: 150,
                  child: DailySchedule(onDateSelected: cubit.onDateSelected),
                ),
                ConditionalBuilder(
                  condition: cubit.currentTasks.isNotEmpty,
                  builder: (context) => const NewTodoAppScreen(),
                  fallback: (context) => emptyTaskWidget(),
                ),
                Container(
                  width: 169,
                  height: 63,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: mainButtonColor,
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      navigateTo(context, const FocusMode(initialMinutes: 1));
                    },
                    child: const Text(
                      "Focus Mode",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                sizedBoxHeight(80),
              ],
            ),
          ),
          floatingActionButton: SizedBox(
            height: 70,
            width: 70,
            child: FloatingActionButton(
              onPressed: () {
                navigateTo(context, AddTask());
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  50,
                ),
              ),
              backgroundColor: mainButtonColor,
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 32,
              ),
            ),
          ),
        );
      },
    );
  }
}
