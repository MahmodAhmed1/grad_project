import 'package:flutter/material.dart';
import 'package:pyramend/dashboard/views/task_management_status/button_state_Container.dart';
// import 'package:pyramend/My_Dashboard/task_management_status/button_state_Container.dart';
import 'package:pyramend/task_management/shared/components/components.dart';

class TaskItemContainer extends StatelessWidget {
  final Map<String, dynamic> task;
  final dynamic cubit;

  const TaskItemContainer({required this.task, required this.cubit, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TaskCubit cubit = TaskCubit.get(context);
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        // color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        color: Color.fromARGB(31, 201, 201, 201),
      ),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  cubit.categoryColorList[task["category"]]?.color,
                  const Color.fromARGB(255, 230, 230, 230)
                ], // Define the gradient colors here
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
            ),
          ),
          sizedBoxWidth(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${task["taskName"]}",
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
                sizedBoxHeight(5),
                Text(
                  "${task["time"]}",
                  style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          ButtonStateContainer(task: task, cubit: cubit),
        ],
      ),
    );
  }
}
