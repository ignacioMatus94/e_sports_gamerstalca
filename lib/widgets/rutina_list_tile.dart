import 'package:flutter/material.dart';
import '../models/rutina.dart';

class RutinaListTile extends StatelessWidget {
  final Rutina rutina;
  final void Function()? onTap;

  const RutinaListTile({
    super.key,
    required this.rutina,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: const Icon(Icons.fitness_center),
      title: Text(rutina.nombre),
      subtitle: Text('Dificultad: ${rutina.dificultad}'),
      children: [
        ListTile(
          leading: const Icon(Icons.description),
          title: Text('Descripción: ${rutina.descripcion}'),
        ),
        ListTile(
          leading: const Icon(Icons.flag),
          title: Text('Objetivo: ${rutina.objetivo}'),
        ),
        ListTile(
          leading: const Icon(Icons.list),
          title: Text('Pasos: ${rutina.pasos}'),
        ),
        ListTile(
          leading: const Icon(Icons.check_circle),
          title: Text('Resultados Esperados: ${rutina.resultadosEsperados}'),
        ),
        if (onTap != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              onPressed: onTap,
              child: const Text('Seleccionar'),
            ),
          ),
      ],
    );
  }
}
