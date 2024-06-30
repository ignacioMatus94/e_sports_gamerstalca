import 'dart:convert';

class Avance {
  final int? id;
  final int perfilId;
  final int rutinaId;
  final int juegoId;
  final String nombre;
  final String descripcion;
  final String objetivo;
  final Map<String, bool> pasos;
  final String resultadosEsperados;
  final String dificultad;
  final double puntuacion;
  final String fecha;
  final int progreso;

  Avance({
    this.id,
    required this.perfilId,
    required this.rutinaId,
    required this.juegoId,
    required this.nombre,
    required this.descripcion,
    required this.objetivo,
    required this.pasos,
    required this.resultadosEsperados,
    required this.dificultad,
    required this.puntuacion,
    required this.fecha,
    required this.progreso,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'perfil_id': perfilId,
      'rutina_id': rutinaId,
      'juego_id': juegoId,
      'nombre': nombre,
      'descripcion': descripcion,
      'objetivo': objetivo,
      'pasos': jsonEncode(pasos), // Convert Map to JSON string
      'resultadosEsperados': resultadosEsperados,
      'dificultad': dificultad,
      'puntuacion': puntuacion,
      'fecha': fecha,
      'progreso': progreso,
    };
  }

  factory Avance.fromMap(Map<String, dynamic> map) {
    return Avance(
      id: map['id'],
      perfilId: map['perfil_id'],
      rutinaId: map['rutina_id'],
      juegoId: map['juego_id'],
      nombre: map['nombre'],
      descripcion: map['descripcion'],
      objetivo: map['objetivo'],
      pasos: Map<String, bool>.from(jsonDecode(map['pasos'])), // Convert JSON string back to Map
      resultadosEsperados: map['resultadosEsperados'],
      dificultad: map['dificultad'],
      puntuacion: map['puntuacion'],
      fecha: map['fecha'],
      progreso: map['progreso'],
    );
  }
}
