import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:e_sports_gamerstalca/models/routine.dart';

class RoutineCard extends StatelessWidget {
  final Routine routine;
  final double progress;
  final bool canSelectAgain;
  final int timeLeft;
  final Function(Routine) onUpdateProgress;
  final Function(Routine)? onNextPhase;
  final Function(Routine) onResetProgress;
  final Function(Routine) onResetPhase;
  final String gameImageUrl;
  final Function(Routine) onIncreaseProgress;

  const RoutineCard({
    super.key,
    required this.routine,
    required this.progress,
    required this.canSelectAgain,
    required this.timeLeft,
    required this.onUpdateProgress,
    this.onNextPhase,
    required this.onResetProgress,
    required this.onResetPhase,
    required this.gameImageUrl,
    required this.onIncreaseProgress,
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
        children: [
          ListTile(
            leading: Icon(
              progress >= 100
                  ? Icons.check_circle
                  : progress >= 66
                      ? Icons.check_circle_outline
                      : Icons.check_box_outline_blank,
              color: progress >= 100
                  ? Colors.green
                  : progress >= 66
                      ? Colors.orange
                      : progress >= 33
                          ? Colors.yellow
                          : Colors.red,
              size: 30,
            ),
            title: Text('Progreso: ${progress.toStringAsFixed(1)}%'),
          ),
          ...stepsMap.entries.map((entry) {
            return ListTile(
              leading: Icon(
                entry.value ? Icons.check_circle : Icons.cancel,
                color: entry.value ? Colors.green : Colors.red,
                size: 30,
              ),
              title: Text(entry.key),
            );
          }).toList(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Wrap(
              spacing: 16.0,
              children: [
                IconButton(
                  icon: const Icon(Icons.restart_alt),
                  onPressed: () => onResetProgress(routine),
                ),
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () => onResetPhase(routine),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => onIncreaseProgress(routine),
                ),
                if (onNextPhase != null)
                  IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: () => onNextPhase!(routine),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
