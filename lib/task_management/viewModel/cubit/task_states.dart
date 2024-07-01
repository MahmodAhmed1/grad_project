abstract class TaskStates {}

class AppInitialStates extends TaskStates {}

class AppChangeBottomNavBarStates extends TaskStates {}

class AppCreateDatabaseStates extends TaskStates {}

class AppInsertInDatabaseStates extends TaskStates {}

class AppGetFromDatabaseStates extends TaskStates {}

class AppChangeValueInAddTaskStates extends TaskStates {}

class AppUpdateStatusInDatabaseStates extends TaskStates {}

class AppDeleteTaskFromDatabaseStates extends TaskStates {}

class AppChangeModeThemeState extends TaskStates {}

class AppChangeAddTaskPriorityValueState extends TaskStates {}

class AppChangeAddTaskCategoryValueState extends TaskStates {}

class AppChangeTaskDateState extends TaskStates {}

class TaskLoading extends TaskStates {}

class TaskDeletedSuccessfully extends TaskStates {}

class TaskLoaded extends TaskStates {
  final List<dynamic> tasks;

  TaskLoaded(this.tasks);
}

class TaskError extends TaskStates {
  final String message;

  TaskError(this.message);
}
