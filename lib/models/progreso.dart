class Progreso {
  int? id;
  int rutinaId;
  String fecha;
  int pasosRealizados;

  Progreso({
    this.id,
    required this.rutinaId,
    required this.fecha,
    required this.pasosRealizados,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'rutinaId': rutinaId,
      'fecha': fecha,
      'pasosRealizados': pasosRealizados,
    };
  }

  factory Progreso.fromMap(Map<String, dynamic> map) {
    return Progreso(
      id: map['id'],
      rutinaId: map['rutinaId'],
      fecha: map['fecha'],
      pasosRealizados: map['pasosRealizados'],
    );
  }
}
