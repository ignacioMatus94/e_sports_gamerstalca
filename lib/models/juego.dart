import 'rutina.dart';

class Juego {
  final int id;
  final String nombre;
  final String imagenUrl;
  final String genero;
  final int ano;
  final String desarrollador;
  final String descripcion;
  final String link;
  final double puntuacion;
  final List<Rutina> rutinas;

  Juego({
    required this.id,
    required this.nombre,
    required this.imagenUrl,
    required this.genero,
    required this.ano,
    required this.desarrollador,
    required this.descripcion,
    required this.link,
    required this.puntuacion,
    required this.rutinas,
  });

  factory Juego.fromMap(Map<String, dynamic> map) {
    return Juego(
      id: map['id'],
      nombre: map['nombre'],
      imagenUrl: map['imagenUrl'],
      genero: map['genero'],
      ano: map['ano'],
      desarrollador: map['desarrollador'],
      descripcion: map['descripcion'],
      link: map['link'],
      puntuacion: map['puntuacion'],
      rutinas: List<Rutina>.from(map['rutinas']?.map((x) => Rutina.fromMap(x)) ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'imagenUrl': imagenUrl,
      'genero': genero,
      'ano': ano,
      'desarrollador': desarrollador,
      'descripcion': descripcion,
      'link': link,
      'puntuacion': puntuacion,
      'rutinas': rutinas.map((x) => x.toMap()).toList(),
    };
  }
}
