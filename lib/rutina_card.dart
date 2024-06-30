import 'package:flutter/material.dart';
import '../models/juego.dart';
import '../models/rutina.dart';

class RutinaCard extends StatelessWidget {
  final Juego juego;
  final Rutina? rutinaSeleccionada;
  final void Function(int, Rutina) onRutinaSelected;

  const RutinaCard({
    super.key,
    required this.juego,
    required this.rutinaSeleccionada,
    required this.onRutinaSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(juego.nombre, style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.purple)),
            const SizedBox(height: 10),
            const Text('Puntuación máxima del juego: 10', style: TextStyle(color: Colors.purple)),
            const SizedBox(height: 10),
            Column(
              children: juego.rutinas.map((rutina) {
                return RadioListTile<Rutina>(
                  title: Text('${rutina.nombre} (Puntuación: ${rutina.puntuacion})'),
                  subtitle: Text(rutina.descripcion),
                  value: rutina,
                  groupValue: rutinaSeleccionada,
                  onChanged: (Rutina? value) {
                    if (value != null) {
                      onRutinaSelected(juego.id, value);
                    }
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
            if (rutinaSeleccionada != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rutina seleccionada: ${rutinaSeleccionada!.nombre}',
                    style: const TextStyle(color: Colors.purple),
                  ),
                  const SizedBox(height: 10),
                  Text('Pasos:', style: const TextStyle(fontWeight: FontWeight.bold)),
                  ..._buildPasosList(rutinaSeleccionada!.pasos),
                ],
              ),
            if (rutinaSeleccionada == null)
              const Text('No hay rutina seleccionada', style: TextStyle(color: Colors.purple)),
          ],
        ),
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
}