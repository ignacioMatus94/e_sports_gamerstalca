import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/routine.dart';

class RoutineCard extends StatelessWidget {
  final Routine routine;
  final double progress;
  final bool canSelectAgain;
  final int timeLeft;
  final Function(Routine) onUpdateProgress;
  final Function(Routine) onNextPhase;
  final String gameImageUrl;

  // Constructor
  const RoutineCard({
    super.key, // Usar super.key para el linter `use_super_parameters`
    required this.routine,
    required this.progress,
    required this.canSelectAgain,
    required this.timeLeft,
    required this.onUpdateProgress,
    required this.onNextPhase,
    required this.gameImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final stepsMap = jsonDecode(routine.steps) as Map<String, dynamic>;

    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: ExpansionTile(
        leading: Image.asset(
          gameImageUrl,
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
            Text('Tiempo restante: $timeLeft s'),
            const SizedBox(height: 5),
            Text(
              'Fecha seleccionada: ${routine.selectedAt != null ? DateFormat('dd/MM/yyyy HH:mm').format(DateTime.parse(routine.selectedAt!)) : 'No seleccionada'}',
            ),
          ],
        ),
        trailing: canSelectAgain
            ? ElevatedButton(
                onPressed: () => onNextPhase(routine),
                child: const Text('Siguiente Fase'),
              )
            : null,
        children: stepsMap.entries.map((entry) {
          return ListTile(
            leading: Icon(
              entry.value ? Icons.check_circle : Icons.cancel,
              color: entry.value ? Colors.green : Colors.red,
            ),
            title: Text(entry.key),
          );
        }).toList(),
      ),
    );
  }
}
