class Historial {
  final int id;
  final int rutinaId;
  final String descripcion;
  final String fecha;

  Historial({
    required this.id,
    required this.rutinaId,
    required this.descripcion,
    required this.fecha,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'rutinaId': rutinaId,
      'descripcion': descripcion,
      'fecha': fecha,
    };
  }

  factory Historial.fromMap(Map<String, dynamic> map) {
    return Historial(
      id: map['id'],
      rutinaId: map['rutinaId'],
      descripcion: map['descripcion'],
      fecha: map['fecha'],
    );
  }
}
