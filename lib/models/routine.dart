import 'dart:convert';

class Routine {
  final int id;
  final String name;
  final String description;
  final String objective;
  String steps; 
  final String expectedResults;
  final String difficulty;
  final double rating;
  final int gameId;
  String? selectedAt;
  final String imageUrl; 

  Routine({
    required this.id,
    required this.name,
    required this.description,
    required this.objective,
    required this.steps,
    required this.expectedResults,
    required this.difficulty,
    required this.rating,
    required this.gameId,
    this.selectedAt,
    required this.imageUrl,
  });

  Routine copyWith({
    int? id,
    String? name,
    String? description,
    String? objective,
    String? steps,
    String? expectedResults,
    String? difficulty,
    double? rating,
    int? gameId,
    String? selectedAt,
    String? imageUrl, 
  }) {
    return Routine(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      objective: objective ?? this.objective,
      steps: steps ?? this.steps,
      expectedResults: expectedResults ?? this.expectedResults,
      difficulty: difficulty ?? this.difficulty,
      rating: rating ?? this.rating,
      gameId: gameId ?? this.gameId,
      selectedAt: selectedAt ?? this.selectedAt,
      imageUrl: imageUrl ?? this.imageUrl, 
    );
  }

  factory Routine.fromMap(Map<String, dynamic> map) {
    return Routine(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      objective: map['objective'],
      steps: map['steps'],
      expectedResults: map['expectedResults'],
      difficulty: map['difficulty'],
      rating: map['rating'],
      gameId: map['gameId'],
      selectedAt: map['selectedAt'],
      imageUrl: map['imageUrl'], 
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'objective': objective,
      'steps': steps,
      'expectedResults': expectedResults,
      'difficulty': difficulty,
      'rating': rating,
      'gameId': gameId,
      'selectedAt': selectedAt,
      'imageUrl': imageUrl,
    };
  }

  // Método para obtener el progreso
  double get progress {
    final stepsMap = jsonDecode(steps) as Map<String, dynamic>;
    final completedSteps = stepsMap.values.where((value) => value).length;
    final totalSteps = stepsMap.length;
    return totalSteps > 0 ? (completedSteps / totalSteps) * 100.0 : 0.0;
  }

  // Método para actualizar los pasos
  void updateSteps(Map<String, dynamic> newSteps) {
    steps = jsonEncode(newSteps);
  }
}
