import 'package:flutter/material.dart';

class PantallaRecordatorios extends StatelessWidget {
  const PantallaRecordatorios({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> reminders = [
      'Recordatorio 1: Entrena diariamente',
      'Recordatorio 2: Revisa tus estadísticas',
      'Recordatorio 3: Participa en torneos',
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: reminders.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.white,
                    shadowColor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      leading: Icon(Icons.notifications, color: Theme.of(context).colorScheme.primary),
                      title: Text(
                        reminders[index],
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
            child: Image.asset('assets/clock.png', height: 100), // Imagen de clock.png
          ),
        ],
      ),
    );
  }
}
