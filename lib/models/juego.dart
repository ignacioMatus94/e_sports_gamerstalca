import 'package:equatable/equatable.dart';
import 'rutina.dart';

class Juego extends Equatable {
  final int id;
  final String nombre;
  final String descripcion;
  final String imagenUrl;
  final String genero;
  final int ano;
  final String desarrollador;
  final String link;
  final double puntuacion;
  final List<Rutina> rutinas;

  Juego({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.imagenUrl,
    required this.genero,
    required this.ano,
    required this.desarrollador,
    required this.link,
    required this.puntuacion,
    required this.rutinas,
  });

  factory Juego.fromMap(Map<String, dynamic> map) {
    return Juego(
      id: map['id'],
      nombre: map['nombre'],
      descripcion: map['descripcion'],
      imagenUrl: map['imagenUrl'],
      genero: map['genero'],
      ano: map['ano'],
      desarrollador: map['desarrollador'],
      link: map['link'],
      puntuacion: map['puntuacion'],
      rutinas: List<Rutina>.from(map['rutinas']?.map((x) => Rutina.fromMap(x)) ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'imagenUrl': imagenUrl,
      'genero': genero,
      'ano': ano,
      'desarrollador': desarrollador,
      'link': link,
      'puntuacion': puntuacion,
      'rutinas': rutinas.map((x) => x.toMap()).toList(),
    };
  }

  @override
  List<Object> get props => [
        id,
        nombre,
        descripcion,
        imagenUrl,
        genero,
        ano,
        desarrollador,
        link,
        puntuacion,
        rutinas,
      ];

  @override
  String toString() {
    return 'Juego{id: $id, nombre: $nombre, descripcion: $descripcion, imagenUrl: $imagenUrl, genero: $genero, ano: $ano, desarrollador: $desarrollador, link: $link, puntuacion: $puntuacion, rutinas: $rutinas}';
  }
}
