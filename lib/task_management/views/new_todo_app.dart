import 'package:flutter/material.dart';
import 'package:pyramend/task_management/views/task%20item%20box/task_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pyramend/task_management/viewModel/cubit/task_cubit.dart';
import 'package:pyramend/task_management/viewModel/cubit/task_states.dart';
import 'package:pyramend/task_management/shared/components/components.dart';

class NewTodoAppScreen extends StatelessWidget {
  const NewTodoAppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TaskCubit cubit = TaskCubit.get(context);

    return BlocConsumer<TaskCubit, TaskStates>(
      listener: (context, state) {
        if (state is TaskError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        if (state is TaskLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TaskLoaded) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => TaskItem(
                      task: cubit.currentTasks[index],
                      cubit: cubit,
                    ),
                    itemCount: cubit.currentTasks.length,
                  ),
                ],
              ),
            ),
          );
        } else {
          return emptyTaskWidget();
        }
      },
    );
  }
}
