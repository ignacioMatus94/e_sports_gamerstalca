class Perfil {
  final int id;
  final String nombreUsuario;
  final String email;
  final String avatarUrl;
  final int nivel;
  final int puntos;

  Perfil({
    required this.id,
    required this.nombreUsuario,
    required this.email,
    required this.avatarUrl,
    required this.nivel,
    required this.puntos,
  });

  factory Perfil.fromMap(Map<String, dynamic> map) {
    return Perfil(
      id: map['id'],
      nombreUsuario: map['nombreUsuario'],
      email: map['email'],
      avatarUrl: map['avatarUrl'],
      nivel: map['nivel'],
      puntos: map['puntos'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombreUsuario': nombreUsuario,
      'email': email,
      'avatarUrl': avatarUrl,
      'nivel': nivel,
      'puntos': puntos,
    };
  }
}
