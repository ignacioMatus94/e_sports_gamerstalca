import 'package:equatable/equatable.dart';

class Avance extends Equatable {
  final int? id;
  final int perfilId;
  final int rutinaId;
  final DateTime fecha;
  final int progreso;

  Avance({
    required this.id,
    required this.perfilId,
    required this.rutinaId,
    required this.fecha,
    required this.progreso,
  });

  factory Avance.fromMap(Map<String, dynamic> map) {
    return Avance(
      id: map['id'],
      perfilId: map['perfil_id'],
      rutinaId: map['rutina_id'],
      fecha: DateTime.parse(map['fecha']),
      progreso: map['progreso'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'perfil_id': perfilId,
      'rutina_id': rutinaId,
      'fecha': fecha.toIso8601String(),
      'progreso': progreso,
    };
  }

  @override
  List<Object?> get props => [id, perfilId, rutinaId, fecha, progreso];
}
