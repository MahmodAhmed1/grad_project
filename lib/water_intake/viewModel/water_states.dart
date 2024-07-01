abstract class WaterStates {}

class AppInitialStates extends WaterStates {}

class AppChangeWaterAmountValueState extends WaterStates {}

class AppLoadingState extends WaterStates {}

class AppDataLoadedState extends WaterStates {}

class AppPercentageOfWaterState extends WaterStates {}

class AppErrorState extends WaterStates {}

class AppWaterConsumptionUpdatedState extends WaterStates {
  final String message;
  final int remaining;

  AppWaterConsumptionUpdatedState(this.message, this.remaining);
}
