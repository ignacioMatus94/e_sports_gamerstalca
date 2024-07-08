class ProfileRoutine {
  final int id;
  final int profileId;
  final int routineId;
  final String selectedDate;
  final int progress;

  ProfileRoutine({
    required this.id,
    required this.profileId,
    required this.routineId,
    required this.selectedDate,
    required this.progress,
  });

  factory ProfileRoutine.fromMap(Map<String, dynamic> map) {
    return ProfileRoutine(
      id: map['id'],
      profileId: map['profileId'],
      routineId: map['routineId'],
      selectedDate: map['selectedDate'],
      progress: map['progress'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'profileId': profileId,
      'routineId': routineId,
      'selectedDate': selectedDate,
      'progress': progress,
    };
  }
}
