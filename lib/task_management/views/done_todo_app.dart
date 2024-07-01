import 'package:flutter/material.dart';
import 'package:pyramend/task_management/shared/components/components.dart';
import 'package:pyramend/task_management/shared/constants/icons.dart';
import 'package:pyramend/task_management/viewModel/cubit/task_cubit.dart';
import 'package:pyramend/task_management/viewModel/cubit/task_states.dart';
import 'package:pyramend/task_management/views/task%20item%20box/task_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoneTasks extends StatelessWidget {
  const DoneTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TaskCubit cubit = TaskCubit.get(context);
    return BlocConsumer<TaskCubit, TaskStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: arrowBackIcon,
            ),
            title: const Text(
              "Completed Tasks",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => TaskItem(
                        task: cubit.completedTasks[index], cubit: cubit),
                    separatorBuilder: (context, index) {
                      return Container(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        height: 1,
                        width: double.infinity,
                      );
                    },
                    itemCount: cubit.completedTasks.length,
                  ),
                  sizedBoxHeight(30),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
