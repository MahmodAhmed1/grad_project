class Exercise {
  final String id;
  final String name;
  bool isFinished;
  bool ischosen;
  final int sets;
  final int repeats;
  final int weight;
  final String bodyPart;
  final String equipment;
  final String gifUrl;
  final String target;
  final List<String> secondaryMuscles;
  final List<String> instructions;

  Exercise({
    required this.id,
    required this.name,
    this.isFinished = false,
    this.ischosen = false,
    required this.sets,
    required this.repeats,
    required this.weight,
    required this.bodyPart,
    required this.equipment,
    required this.gifUrl,
    required this.target,
    required this.secondaryMuscles,
    required this.instructions,
  });

  Exercise copyWith({
    bool? isFinished,
    bool? ischosen,
    int? sets,
    int? repeats,
    int? weight,
    List<String>? secondaryMuscles,
    List<String>? instructions,
  }) {
    return Exercise(
      id: this.id,
      name: this.name,
      isFinished: isFinished ?? this.isFinished,
      ischosen: ischosen ?? this.ischosen,
      sets: sets ?? this.sets,
      repeats: repeats ?? this.repeats,
      weight: weight ?? this.weight,
      bodyPart: this.bodyPart,
      equipment: this.equipment,
      gifUrl: this.gifUrl,
      target: this.target,
      secondaryMuscles: secondaryMuscles ?? this.secondaryMuscles,
      instructions: instructions ?? this.instructions,
    );
  }

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['_id'],
      name: json['name'],
      isFinished: json['isFinished'],
      sets: json['sets'],
      repeats: json['repeats'],
      weight: json['weight'],
      bodyPart: json['bodyPart'],
      equipment: json['equipment'],
      gifUrl: json['gifUrl'],
      target: json['target'],
      secondaryMuscles: List<String>.from(json['secondaryMuscles']),
      instructions: List<String>.from(json['instructions']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'isFinished': isFinished,
      'ischosen': ischosen,
      'sets': sets,
      'repeats': repeats,
      'weight': weight,
      'bodyPart': bodyPart,
      'equipment': equipment,
      'gifUrl': gifUrl,
      'target': target,
      'secondaryMuscles': secondaryMuscles,
      'instructions': instructions,
    };
  }
}
