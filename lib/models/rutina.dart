class Rutina {
  final int id;
  final String nombre;
  final String descripcion;
  final String objetivo;
  final String pasos;
  final String resultadosEsperados;
  final String dificultad;

  Rutina({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.objetivo,
    required this.pasos,
    required this.resultadosEsperados,
    required this.dificultad,
  });

  factory Rutina.fromMap(Map<String, dynamic> map) {
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
}
