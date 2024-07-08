class Perfil {
  final int id;
  final String nombre;
  final String email;

  Perfil({
    required this.id,
    required this.nombre,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'email': email,
    };
  }

  static Perfil fromMap(Map<String, dynamic> map) {
    return Perfil(
      id: map['id'],
      nombre: map['nombre'],
      email: map['email'],
    );
  }
}
