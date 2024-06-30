import 'package:flutter/material.dart';
import '../models/juego.dart';
import '../models/avance.dart';

class AvanceCard extends StatelessWidget {
  final Juego juego;
  final Map<int, List<Avance>> avancesMap;

  const AvanceCard({
    Key? key,
    required this.juego,
    required this.avancesMap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ExpansionTile(
        title: Text(
          juego.nombre,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
        children: juego.rutinas.map((rutina) {
          final avancesRutina = avancesMap[rutina.id] ?? [];
          final steps = rutina.pasos.entries.toList();
          final progressPerStep = <String, double>{};
          for (var step in steps) {
            final stepName = step.key;
            final totalCount = avancesRutina.length;
            final completedCount = avancesRutina
                .where((avance) => avance.pasos[stepName] ?? false)
                .length;
            progressPerStep[stepName] = totalCount == 0 ? 0 : (completedCount / totalCount) * 100;
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rutina: ${rutina.nombre}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                _buildProgressTable(progressPerStep),
                const SizedBox(height: 10),
                ..._buildPasosList(rutina.pasos),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  List<Widget> _buildPasosList(Map<String, bool> pasos) {
    return pasos.entries.map((entry) {
      bool realizado = entry.value;
      return ListTile(
        leading: Icon(
          realizado ? Icons.check_circle : Icons.cancel,
          color: realizado ? Colors.green : Colors.red,
        ),
        title: Text(
          entry.key,
          style: const TextStyle(fontSize: 16),
        ),
      );
    }).toList();
  }

  Widget _buildProgressTable(Map<String, double> progressPerStep) {
    return DataTable(
      columnSpacing: 20,
      columns: const [
        DataColumn(label: Text('Paso')),
        DataColumn(
          label: Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Text('Progreso (%)'),
            ),
          ),
        ),
      ],
      rows: progressPerStep.entries.map((entry) {
        return DataRow(
          cells: [
            DataCell(Text(entry.key)),
            DataCell(Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: entry.value / 100,
                    backgroundColor: Colors.grey[300],
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(width: 10),
                Text('${entry.value.toStringAsFixed(1)}%'),
              ],
            )),
          ],
        );
      }).toList(),
    );
  }
}
