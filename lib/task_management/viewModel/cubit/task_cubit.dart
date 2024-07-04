import 'package:flutter/material.dart';
import 'package:pyramend/authentication/views/provider.dart';
import 'package:pyramend/task_management/api/tasks_api.dart';
import 'package:pyramend/task_management/models/task_model.dart';
import 'package:pyramend/task_management/viewModel/cubit/task_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ButtonInfo {
  final Color color;
  final IconData iconData;

  ButtonInfo({required this.color, required this.iconData});
}

class TaskCubit extends Cubit<TaskStates> {
  TaskCubit() : super(AppInitialStates());

  static TaskCubit get(context) => BlocProvider.of(context);

  List<dynamic> allTasks = [];
  List<dynamic> completedTasks = [];
  List<dynamic> currentTasks = [];
  List<dynamic> todayTasks = [];

  Map<String, Color> priorityColorList = {
    "high": const Color.fromARGB(149, 255, 17, 1),
    "medium": const Color.fromARGB(149, 0, 140, 255),
    "low": const Color.fromARGB(149, 1, 165, 7),
  };

  Map<String, ButtonInfo> categoryColorList = {
    "personal": ButtonInfo(
      color: const Color.fromARGB(150, 255, 217, 0), // Gold
      iconData: Icons.person_2_outlined,
    ),
    "work": ButtonInfo(
      color: const Color.fromARGB(150, 70, 131, 180), // Steel Blue
      iconData: Icons.work_outline,
    ),
    "meeting": ButtonInfo(
      color: const Color.fromARGB(150, 50, 205, 50), // Lime Green
      iconData: Icons.home_outlined,
    ),
    "shopping": ButtonInfo(
      color: const Color.fromARGB(150, 255, 140, 0), // Dark Orange
      iconData: Icons.shopping_cart_checkout_outlined,
    ),
    "exercise": ButtonInfo(
      color: const Color.fromARGB(150, 32, 178, 171), // Light Sea Green
      iconData: Icons.fitness_center_outlined,
    ),
    "study": ButtonInfo(
      color: const Color.fromARGB(150, 105, 90, 205), // Slate Blue
      iconData: Icons.book_outlined,
    ),
    "appointment": ButtonInfo(
      color: const Color.fromARGB(150, 186, 85, 211), // Medium Orchid
      iconData: Icons.calendar_today_outlined,
    ),
    "other": ButtonInfo(
      color: const Color.fromARGB(150, 128, 128, 128), // Gray
      iconData: Icons.error_outline_outlined,
    ),
  };

  List<String> categoryTaskInput = [
    "other",
    "personal",
    "work",
    "meeting",
    "shopping",
    "exercise",
    "study",
    "appointment",
  ];

  List<String> priorityTask = [
    "high",
    "low",
    "medium",
  ];

  DateTime currentDate = DateTime.now();
  void onDateSelected(DateTime dateId) {
    // Handle the date selection
    currentDate = dateId;
    fetchTasksByFilter({"date": currentDate});
  }

  void fetchTasks() async {
    emit(TaskLoading());
    try {
      final tasks = await TaskService().fetchTasks();

      allTasks.clear();
      allTasks = tasks;
      emit(TaskLoaded(tasks));
    } catch (error) {
      emit(TaskError('Failed to load tasks'));
    }
  }

  void fetchTasksToday() async {
    emit(TaskLoading());
    try {
      final today = DateTime.now();
      final formattedDate = DateFormat('yyyy-MM-dd').format(today);

      final tasks =
          await TaskService().fetchTasksByFilter({"date": formattedDate});

      // Filter tasks to include only those with state 'in-progress'
      final inProgressTasks =
          tasks.where((task) => task['state'] == 'in-progress').toList();

      todayTasks.clear();
      todayTasks = inProgressTasks;

      emit(TaskLoaded(inProgressTasks));
    } catch (error) {
      emit(TaskError('Failed to load tasks'));
    }
  }

  void fetchTasksByFilter(Map<String, dynamic> filter) async {
    emit(TaskLoading());
    try {
      final tasks = await TaskService().fetchTasksByFilter(filter);
      final DateTime todaySameTime = DateTime.now();
      fetchTasksToday();

      // Function to parse time in 'hh:mm a' format
      DateTime? parseTime(String time) {
        try {
          final DateFormat format = DateFormat('h:mm a');
          final parsedTime = format.parse(time);
          return parsedTime;
        } catch (e) {
          print('Error parsing time: $e');
          return null; // or handle the error accordingly
        }
      }

      // Sort tasks by time/
      tasks.sort((a, b) {
        final DateTime? aTime = parseTime(a['time']);
        final DateTime? bTime = parseTime(b['time']);
        return aTime!.compareTo(bTime!);
      });

      final List<dynamic> filteredTasks = tasks.where((task) {
        final DateTime taskDate = DateTime.parse(task['date']);
        final DateTime? taskTime = parseTime(task['time']);
        final DateTime taskDateTime = DateTime(
          taskDate.year,
          taskDate.month,
          taskDate.day,
          taskTime!.hour,
          taskTime.minute,
          taskTime.second,
        );

        return taskDateTime.isBefore(todaySameTime) &&
            task['state'] != 'finished';
      }).toList();

      final List<dynamic> filteredTasks2 = tasks.where((task) {
        final DateTime taskDate = DateTime.parse(task['date']);
        final DateTime? taskTime = parseTime(task['time']);
        final DateTime taskDateTime = DateTime(
          taskDate.year,
          taskDate.month,
          taskDate.day,
          taskTime!.hour,
          taskTime.minute,
          taskTime.second,
        );

        return taskDateTime.isAfter(todaySameTime) &&
            task['state'] != 'finished';
      }).toList();

      for (var task in filteredTasks2) {
        updateTaskTime({
          "taskName": task["taskName"],
          "state": 'in-progress',
        });
        task['state'] = 'in-progress';
      }
      for (var task in filteredTasks) {
        updateTaskTime({
          "taskName": task["taskName"],
          "state": 'late',
        });
        task['state'] = 'late';
      }

      currentTasks.clear();
      currentTasks = tasks;

      if (filter.containsKey("state") && filter["state"] == "finished") {
        completedTasks.clear();
        completedTasks = tasks;
      }

      emit(TaskLoaded(tasks));
    } catch (error) {
      print('Error occurred: $error');
      emit(TaskError('Failed to load tasks'));
    }
  }

  void addTask({
    required String title,
    required String description,
    required String time,
    required String date,
    required int duration,
    required String category,
    required String priority,
  }) async {
    try {
      Task task = Task(
        taskName: title,
        description: description,
        category: category,
        priority: priority,
        state: "in-progress",
        duration: duration,
        date: date,
        time: time,
      );
      // print(task);
      var result = await TaskService().addTask(task.toMap());
      if (result['success']) {
        showSuccessToastSuc('${result['message']}');
      } else {
        showSuccessToastFail('${result['message']}');
      }
      fetchTasksByFilter(
          {"date": currentDate}); // Refresh tasks after adding a new one
    } catch (e) {
      emit(TaskError('Failed to add task'));
    }
  }

  void deleteTask({
    required String taskName,
  }) async {
    try {
      var result = await TaskService().deleteTask(taskName);
      if (result['success']) {
        showSuccessToastSuc('${result['message']}');
      } else {
        showSuccessToastFail('${result['message']}');
      }
      emit(TaskDeletedSuccessfully());
      fetchTasksByFilter({"date": currentDate});
    } catch (e) {
      emit(TaskError('Failed to delete task'));
    }
  }

  void updateTaskTime(Map<String, dynamic> updatedData) async {
    // emit(TaskLoading());
    try {
      await TaskService().updateTask(updatedData);
      // fetchTasks(); // Refresh tasks after updating one
    } catch (e) {
      emit(TaskError('Failed to update task'));
    }
  }

  void updateTask(Map<String, dynamic> updatedData) async {
    emit(TaskLoading());
    try {
      var result = await TaskService().updateTask(updatedData);
      if (result['success']) {
        showSuccessToastSuc('${result['message']}');
      } else {
        showSuccessToastFail('${result['message']}');
      }
      fetchTasksByFilter(
          {"date": currentDate}); // Refresh tasks after updating one
    } catch (e) {
      emit(TaskError('Failed to update task'));
    }
  }

  void showSuccessToastFail(String msg) async {
    await Future.delayed(const Duration(milliseconds: 100));
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 10,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void showSuccessToastSuc(String msg) async {
    await Future.delayed(const Duration(milliseconds: 100));
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 5,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  //Using in Add & Edit Tasks
  //change duration in add new task page
  Duration duration = const Duration(hours: 0, minutes: 0);
  void setDuration(val) {
    duration = val;
    emit(AppChangeAddTaskPriorityValueState());
  }

  //choice category for task
  String dropdownCategoryValue = "";
  void editTag(value) {
    dropdownCategoryValue = value;
    emit(AppChangeAddTaskCategoryValueState());
  }

  //set priority for task
  String dropdownPriorityValue = "";
  void editPriority(value) {
    dropdownPriorityValue = value;
    emit(AppChangeAddTaskPriorityValueState());
  }

  String convertDateFormat(String date) {
    // Parse the input date in "MMM d, yyyy" format
    DateTime parsedDate = DateFormat('MMM d, yyyy').parse(date);
    // Format the date to "yyyy-MM-dd" format
    String formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);
    return formattedDate;
  }
}
