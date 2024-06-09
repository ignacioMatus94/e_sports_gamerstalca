import 'package:flutter/material.dart';

class PantallaRutinasEntrenamiento extends StatelessWidget {
  const PantallaRutinasEntrenamiento({super.key});

  final List<Map<String, dynamic>> rutinasPorJuego = const [
    {
      'nombre': 'Mario',
      'descripcion': 'Juego clásico de plataformas con Mario el fontanero.',
      'imagen': 'assets/mario.png',
      'mensajeRutina': 'Desarrolla tus habilidades de salto y precisión.',
      'rutinas': [
        {'titulo': 'Rutina 1: Mejora tu precisión en los saltos', 'dificultad': 'Fácil'},
        {'titulo': 'Rutina 2: Aumenta tu tiempo de reacción en plataformas', 'dificultad': 'Medio'},
        {'titulo': 'Rutina 3: Estrategias avanzadas para derrotar a los jefes', 'dificultad': 'Difícil'},
      ],
    },
    {
      'nombre': 'Starcraft',
      'descripcion': 'Juego de estrategia en tiempo real en el espacio.',
      'imagen': 'assets/start.png',
      'mensajeRutina': 'Optimiza tu recolección y gestión de recursos.',
      'rutinas': [
        {'titulo': 'Rutina 1: Optimiza tu recolección de recursos', 'dificultad': 'Fácil'},
        {'titulo': 'Rutina 2: Mejora tu microgestión en batallas', 'dificultad': 'Medio'},
        {'titulo': 'Rutina 3: Desarrolla estrategias avanzadas de combate', 'dificultad': 'Difícil'},
      ],
    },
    {
      'nombre': 'Rayman',
      'descripcion': 'Juego de aventura con Rayman y sus amigos.',
      'imagen': 'assets/rayman.png',
      'mensajeRutina': 'Mejora tu sincronización y encuentra todos los secretos.',
      'rutinas': [
        {'titulo': 'Rutina 1: Perfecciona tu sincronización en saltos', 'dificultad': 'Fácil'},
        {'titulo': 'Rutina 2: Aumenta tu velocidad de reacción en niveles difíciles', 'dificultad': 'Medio'},
        {'titulo': 'Rutina 3: Estrategias avanzadas para encontrar secretos', 'dificultad': 'Difícil'},
      ],
    },
  ];

  Icon _getDifficultyIcon(String dificultad) {
    switch (dificultad) {
      case 'Fácil':
        return const Icon(Icons.star, color: Colors.green);
      case 'Medio':
        return const Icon(Icons.star, color: Colors.orange);
      case 'Difícil':
        return const Icon(Icons.star, color: Colors.red);
      default:
        return const Icon(Icons.star);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade100, Colors.blue.shade300],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: rutinasPorJuego.length,
          itemBuilder: (context, index) {
            String juego = rutinasPorJuego[index]['nombre'];
            String mensajeRutina = rutinasPorJuego[index]['mensajeRutina'];
            String imagen = rutinasPorJuego[index]['imagen'];
            List<Map<String, String>> rutinas = List<Map<String, String>>.from(rutinasPorJuego[index]['rutinas']);

            return Card(
              color: Colors.white,
              shadowColor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: ExpansionTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(imagen, width: 50, height: 50, fit: BoxFit.cover),
                ),
                title: Text(
                  juego,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  mensajeRutina,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey[600]),
                ),
                children: rutinas.map((rutina) {
                  return ListTile(
                    leading: _getDifficultyIcon(rutina['dificultad']!),
                    title: Text(
                      rutina['titulo']!,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black87),
                    ),
                  );
                }).toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}
