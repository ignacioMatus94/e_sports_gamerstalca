import 'dart:convert';

class Rutina {
  final int id;
  final String nombre;
  final String descripcion;
  final String objetivo;
  final Map<String, bool> pasos;
  final String resultadosEsperados;
  final String dificultad;
  final double puntuacion;
  final int juegoId;
  int? perfilId;

  Rutina({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.objetivo,
    required this.pasos,
    required this.resultadosEsperados,
    required this.dificultad,
    required this.puntuacion,
    required this.juegoId,
    this.perfilId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'objetivo': objetivo,
      'pasos': jsonEncode(pasos),
      'resultadosEsperados': resultadosEsperados,
      'dificultad': dificultad,
      'puntuacion': puntuacion,
      'juegoId': juegoId,
      'perfil_id': perfilId,
    };
  }

  factory Rutina.fromMap(Map<String, dynamic> map) {
    return Rutina(
      id: map['id'],
      nombre: map['nombre'],
      descripcion: map['descripcion'],
      objetivo: map['objetivo'],
      pasos: jsonDecode(map['pasos']) is Map<String, dynamic>
          ? (jsonDecode(map['pasos']) as Map<String, dynamic>)
              .map((key, value) => MapEntry(key, value as bool))
          : {},
      resultadosEsperados: map['resultadosEsperados'],
      dificultad: map['dificultad'],
      puntuacion: map['puntuacion'],
      juegoId: map['juegoId'],
      perfilId: map['perfil_id'],
    );
  }
}
