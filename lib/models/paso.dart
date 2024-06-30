// models/paso.dart
class Paso {
  final int? id;
  final int rutinaId;
  final String paso;
  final bool realizado;

  Paso({
    this.id,
    required this.rutinaId,
    required this.paso,
    required this.realizado,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'rutina_id': rutinaId,
      'paso': paso,
      'realizado': realizado ? 1 : 0,
    };
  }

  factory Paso.fromMap(Map<String, dynamic> map) {
    return Paso(
      id: map['id'],
      rutinaId: map['rutina_id'],
      paso: map['paso'],
      realizado: map['realizado'] == 1,
    );
  }
}
