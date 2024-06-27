class Perfil {
  final int id;
  final String nombre;
  final String avatarUrl;

  Perfil({
    required this.id,
    required this.nombre,
    required this.avatarUrl,
  });

  String get nombreUsuario => nombre; // Agrega este getter si no existe

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'avatarUrl': avatarUrl,
    };
  }

  static Perfil fromMap(Map<String, dynamic> map) {
    return Perfil(
      id: map['id'],
      nombre: map['nombre'],
      avatarUrl: map['avatarUrl'],
    );
  }
}
