import 'package:flutter/material.dart';

class PantallaRutinasEntrenamiento extends StatelessWidget {
  const PantallaRutinasEntrenamiento({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> routines = [
      'Rutina 1: Mejora tu precisión',
      'Rutina 2: Aumenta tu tiempo de reacción',
      'Rutina 3: Estrategias avanzadas',
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: routines.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.white,
                    shadowColor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      leading: Icon(Icons.fitness_center, color: Theme.of(context).colorScheme.primary),
                      title: Text(
                        routines[index],
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0), // Aumentar el padding
            child: Image.asset('assets/logo.png', height: 100), // Aumentar la altura de la imagen
          ),
        ],
      ),
    );
  }
}
