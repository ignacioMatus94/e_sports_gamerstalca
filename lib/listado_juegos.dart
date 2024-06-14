import 'package:flutter/material.dart';
import 'drawer_clase.dart';

class PantallaListadoJuegos extends StatefulWidget {
  const PantallaListadoJuegos({super.key});

  @override
  PantallaListadoJuegosState createState() => PantallaListadoJuegosState();
}

class PantallaListadoJuegosState extends State<PantallaListadoJuegos> {
  final List<Map<String, dynamic>> games = [
    {
      'nombre': 'Mario',
      'genero': 'Plataformas',
      'descripcion': 'Juego clásico de plataformas con Mario el fontanero.',
      'imagen': 'assets/mario.png',
      'lanzamiento': '1985',
      'desarrollador': 'Nintendo',
      'detalles': [
        'Género: Plataformas',
        'Lanzamiento: 1985',
        'Desarrollador: Nintendo',
        'Descripción: Juego clásico de plataformas con Mario el fontanero.'
      ],
    },
    {
      'nombre': 'Starcraft',
      'genero': 'Estrategia en Tiempo Real',
      'descripcion': 'Juego de estrategia en tiempo real en el espacio.',
      'imagen': 'assets/start.png',
      'lanzamiento': '1998',
      'desarrollador': 'Blizzard Entertainment',
      'detalles': [
        'Género: Estrategia en Tiempo Real',
        'Lanzamiento: 1998',
        'Desarrollador: Blizzard Entertainment',
        'Descripción: Juego de estrategia en tiempo real en el espacio.'
      ],
    },
    {
      'nombre': 'Rayman',
      'genero': 'Aventura',
      'descripcion': 'Juego de aventura con Rayman y sus amigos.',
      'imagen': 'assets/rayman.png',
      'lanzamiento': '1995',
      'desarrollador': 'Ubisoft',
      'detalles': [
        'Género: Aventura',
        'Lanzamiento: 1995',
        'Desarrollador: Ubisoft',
        'Descripción: Juego de aventura con Rayman y sus amigos.'
      ],
    },
  ];

  Icon _getIconForGenre(String genre) {
    switch (genre) {
      case 'Plataformas':
        return const Icon(Icons.videogame_asset, color: Colors.green);
      case 'Estrategia en Tiempo Real':
        return const Icon(Icons.sports_esports, color: Colors.blue);
      case 'Aventura':
        return const Icon(Icons.explore, color: Colors.orange);
      default:
        return const Icon(Icons.videogame_asset);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DrawerClase.buildScaffold(
      context,
      'Listado de Juegos',
      Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade100, Colors.blue.shade300],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: games.length,
          itemBuilder: (context, index) {
            String juego = games[index]['nombre'];
            String descripcion = games[index]['descripcion'];
            String imagen = games[index]['imagen'];
            List<String> detalles = List<String>.from(games[index]['detalles'] ?? []);

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
                  descripcion,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey[600]),
                ),
                children: detalles.map((detalle) {
                  return ListTile(
                    leading: _getIconForGenre(games[index]['genero']),
                    title: Text(
                      detalle,
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
