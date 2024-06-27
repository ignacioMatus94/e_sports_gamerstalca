import 'package:equatable/equatable.dart';

class Rutina extends Equatable {
  final int? id;
  final String nombre;
  final String descripcion;
  final String objetivo;
  final String pasos;
  final String resultadosEsperados;
  final String dificultad;

  Rutina({
    this.id,
    required this.nombre,
    required this.descripcion,
    required this.objetivo,
    required this.pasos,
    required this.resultadosEsperados,
    required this.dificultad,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'objetivo': objetivo,
      'pasos': pasos,
      'resultadosEsperados': resultadosEsperados,
      'dificultad': dificultad,
    };
  }

  static Rutina fromMap(Map<String, dynamic> map) {
    return Rutina(
      id: map['id'],
      nombre: map['nombre'],
      descripcion: map['descripcion'],
      objetivo: map['objetivo'],
      pasos: map['pasos'],
      resultadosEsperados: map['resultadosEsperados'],
      dificultad: map['dificultad'],
    );
  }

  @override
  List<Object?> get props => [id, nombre, descripcion, objetivo, pasos, resultadosEsperados, dificultad];

  @override
  String toString() {
    return 'Rutina{id: $id, nombre: $nombre, descripcion: $descripcion, objetivo: $objetivo, pasos: $pasos, resultadosEsperados: $resultadosEsperados, dificultad: $dificultad}';
  }
}
