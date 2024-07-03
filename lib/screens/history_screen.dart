import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/routine.dart';
import '../app_drawer.dart';

class HistoryScreen extends StatelessWidget {
  final Map<int, double> progressMap;
  final List<Routine> routines;

  const HistoryScreen({
    super.key,
    required this.progressMap,
    required this.routines,
  });

  @override
  Widget build(BuildContext context) {
    // Filtrar solo las rutinas seleccionadas
    final selectedRoutines = routines.where((routine) => routine.selectedAt != null).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial'),
      ),
      drawer: AppDrawer(), // Agregar el Drawer aquí
      body: ListView.builder(
        itemCount: selectedRoutines.length,
        itemBuilder: (context, index) {
          final routine = selectedRoutines[index];
          final progress = progressMap[routine.id] ?? 0.0;
          final selectedDate = routine.selectedAt != null
              ? DateFormat('dd/MM/yyyy HH:mm').format(DateTime.parse(routine.selectedAt!))
              : 'No seleccionada';
          return Card(
            elevation: 5,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),
              leading: Image.asset(
                _getGameImage(routine.gameId),
                fit: BoxFit.cover,
                width: 50,
                height: 50,
              ),
              title: Text(
                routine.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Progreso: ${progress.toStringAsFixed(1)}%'),
                  const SizedBox(height: 5),
                  Text('Fecha seleccionada: $selectedDate'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String _getGameImage(int gameId) {
    switch (gameId) {
      case 1:
        return 'assets/mario.png';
      case 2:
        return 'assets/rayman.png';
      case 3:
        return 'assets/starcraft.png';
      case 4:
        return 'assets/pacman.png';
      default:
        return 'assets/games.png';
    }
  }
}
