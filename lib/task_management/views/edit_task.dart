import 'package:flutter/material.dart';
import 'package:pyramend/task_management/shared/constants/icons.dart';
import 'package:pyramend/task_management/viewModel/cubit/task_cubit.dart';
import 'package:pyramend/task_management/viewModel/cubit/task_states.dart';
import 'package:pyramend/task_management/views/add_edit_fields_task/category_field.dart';
import 'package:pyramend/task_management/views/add_edit_fields_task/date_field.dart';
import 'package:pyramend/task_management/views/add_edit_fields_task/description_field.dart';
import 'package:pyramend/task_management/views/add_edit_fields_task/duration_field.dart';
import 'package:pyramend/task_management/views/add_edit_fields_task/priority_field.dart';
import 'package:pyramend/task_management/views/add_edit_fields_task/time_field.dart';
import 'package:pyramend/task_management/views/add_edit_fields_task/title_field.dart';
import 'package:pyramend/task_management/views/add_edit_fields_task/update_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class UpdateTask extends StatelessWidget {
  final Map<String, dynamic> task;

  UpdateTask({required this.task, Key? key}) : super(key: key);

  final titleController = TextEditingController();
  final timeController = TextEditingController();
  final dateController = TextEditingController();
  final descriptionController = TextEditingController();
  final durationController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TaskCubit cubit = TaskCubit.get(context);
    _initializeFields(cubit);

    return BlocConsumer<TaskCubit, TaskStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              _resetState(context);
              Navigator.pop(context);
            },
            icon: arrowBackIcon,
          ),
          title: const Text(
            "Update Task",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleField(controller: titleController),
                  const SizedBox(height: 20),
                  DescriptionField(controller: descriptionController),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: DateField(controller: dateController),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: DurationField(controller: durationController),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TimeField(controller: timeController),
                  const SizedBox(height: 20),
                  PriorityField(cubit: cubit),
                  const SizedBox(height: 20),
                  CategoryField(cubit: cubit),
                  const SizedBox(height: 50),
                  UpdateButton(
                    formKey: formKey,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        if (cubit.dropdownCategoryValue.isEmpty) {
                          cubit.dropdownCategoryValue = "No Category";
                        }
                        var date = cubit.convertDateFormat(dateController.text);
                        cubit.updateTask({
                          "taskName": titleController.text,
                          "description": descriptionController.text,
                          "time": timeController.text,
                          "date": date,
                          "duration": int.parse(durationController.text),
                          "category": cubit.dropdownCategoryValue,
                          "priority": cubit.dropdownPriorityValue,
                        });
                        _resetState(context);
                        Navigator.pop(context);
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _initializeFields(TaskCubit cubit) {
    titleController.text = task['taskName'];
    descriptionController.text = task['description'];
    timeController.text = task['time'];
    dateController.text =
        DateFormat.yMMMd().format(DateTime.parse(task['date']));
    durationController.text = task['duration'].toString();
    cubit.dropdownPriorityValue = task['priority'];
    cubit.dropdownCategoryValue = task['category'];
  }

  void _resetState(BuildContext context) {
    titleController.clear();
    descriptionController.clear();
    timeController.clear();
    dateController.clear();
    durationController.clear();
    TaskCubit.get(context).dropdownPriorityValue = "";
    TaskCubit.get(context).dropdownCategoryValue = "";
  }
}
