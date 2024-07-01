class WaterIntakeData {
  final int waterTarget;
  final int waterConsume;
  final int weight;
  final String userName;
  final DateTime now;

  WaterIntakeData({
    required this.waterTarget,
    required this.waterConsume,
    required this.weight,
    required this.userName,
    required this.now,
  });

  factory WaterIntakeData.fromJson(Map<String, dynamic> json) {
    return WaterIntakeData(
      waterTarget: json['waterTarget'] ?? 0,
      waterConsume: json['waterConsume'] ?? 0,
      weight: json['weight'] ?? 0,
      userName: json['userName'] ?? '',
      now: DateTime.parse(json['now'] ?? DateTime.now().toString()),
    );
  }
}
