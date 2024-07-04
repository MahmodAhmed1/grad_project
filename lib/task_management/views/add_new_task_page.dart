import 'package:flutter/material.dart';
import 'package:pyramend/task_management/views/add_edit_fields_task/category_field.dart';
import 'package:pyramend/task_management/views/add_edit_fields_task/date_field.dart';
import 'package:pyramend/task_management/views/add_edit_fields_task/description_field.dart';
import 'package:pyramend/task_management/views/add_edit_fields_task/duration_field.dart';
import 'package:pyramend/task_management/views/add_edit_fields_task/priority_field.dart';
import 'package:pyramend/task_management/views/add_edit_fields_task/time_field.dart';
import 'package:pyramend/task_management/views/add_edit_fields_task/title_field.dart';
import 'package:pyramend/task_management/shared/constants/colors.dart';
import 'package:pyramend/task_management/shared/constants/icons.dart';
import 'package:pyramend/task_management/viewModel/cubit/task_cubit.dart';
import 'package:pyramend/task_management/viewModel/cubit/task_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class AddTask extends StatelessWidget {
  AddTask({super.key});

  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  var descriptionController = TextEditingController();
  var durationController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void initialState(BuildContext context) {
    titleController.clear();
    descriptionController.clear();
    timeController.clear();
    dateController.clear();
    durationController.clear();
    TaskCubit.get(context).dropdownPriorityValue = "";
    TaskCubit.get(context).dropdownCategoryValue = "";
  }

  @override
  Widget build(BuildContext context) {
    TaskCubit cubit = TaskCubit.get(context);
    return BlocConsumer<TaskCubit, TaskStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              initialState(context);
              Navigator.pop(context);
            },
            icon: arrowBackIcon,
          ),
          title: const Text(
            "Add Task",
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
              child: SizedBox(
                width: double.infinity,
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
                        Expanded(child: DateField(controller: dateController)),
                        const SizedBox(width: 15),
                        Expanded(
                            child:
                                DurationField(controller: durationController)),
                      ],
                    ),
                    const SizedBox(height: 20),
                    TimeField(controller: timeController),
                    const SizedBox(height: 20),
                    PriorityField(cubit: cubit),
                    const SizedBox(height: 20),
                    CategoryField(cubit: cubit),
                    const SizedBox(height: 50),
                    Container(
                      width: double.infinity,
                      height: 63,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: mainButtonColor,
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            if (cubit.dropdownCategoryValue.isEmpty) {
                              cubit.dropdownCategoryValue = "No Category";
                            }

                            var date =
                                cubit.convertDateFormat(dateController.text);

                            cubit.addTask(
                              title: titleController.text,
                              description: descriptionController.text,
                              time: timeController.text,
                              date: date,
                              duration: int.parse(durationController.text),
                              category: cubit.dropdownCategoryValue,
                              priority: cubit.dropdownPriorityValue,
                            );
                            if (int.parse(durationController.text) != 0) {
                              initialState(context);
                              Navigator.pop(context);
                            }
                          }
                        },
                        child: const Text(
                          "Save",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
