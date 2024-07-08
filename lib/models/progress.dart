class Progress {
  final int id;
  final int routineId;
  final String date;
  final int stepsCompleted;

  Progress({
    required this.id,
    required this.routineId,
    required this.date,
    required this.stepsCompleted,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'routineId': routineId,
      'date': date,
      'stepsCompleted': stepsCompleted,
    };
  }

  static Progress fromMap(Map<String, dynamic> map) {
    return Progress(
      id: map['id'],
      routineId: map['routineId'],
      date: map['date'],
      stepsCompleted: map['stepsCompleted'],
    );
  }
}
