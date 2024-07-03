class History {
  final int id;
  final int routineId;
  final String description;
  final String date;

  History({
    required this.id,
    required this.routineId,
    required this.description,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'routineId': routineId,
      'description': description,
      'date': date,
    };
  }

  static History fromMap(Map<String, dynamic> map) {
    return History(
      id: map['id'],
      routineId: map['routineId'],
      description: map['description'],
      date: map['date'],
    );
  }
}
