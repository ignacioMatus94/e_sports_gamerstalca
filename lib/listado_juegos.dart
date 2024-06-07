import 'package:flutter/material.dart';

class PantallaListadoJuegos extends StatelessWidget {
  const PantallaListadoJuegos({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> games = ['Juego 1', 'Juego 2', 'Juego 3'];

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: games.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.white,
                    shadowColor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      leading: Icon(Icons.videogame_asset, color: Theme.of(context).colorScheme.primary),
                      title: Text(
                        games[index],
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset('assets/games.png', height: 100), // Imagen de games.png
          ),
        ],
      ),
    );
  }
}
