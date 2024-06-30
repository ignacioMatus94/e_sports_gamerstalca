import 'package:flutter/material.dart';
import '../models/rutina.dart';
import '../models/perfil.dart';
import '../widgets/drawer_clase.dart';

class PantallaDetalleRutina extends StatelessWidget {
  final Rutina rutina;
  final List<Perfil> perfiles;
  final List<Rutina> rutinasSeleccionadas;

  const PantallaDetalleRutina({
    super.key,
    required this.rutina,
    required this.perfiles,
    required this.rutinasSeleccionadas,
  });

  @override
  Widget build(BuildContext context) {
    final Map<int, Rutina> rutinasSeleccionadasMap = {
      for (var rutina in rutinasSeleccionadas) rutina.id: rutina
    };

    return DrawerClase.buildScaffold(
      context: context,
      title: 'Detalles de la Rutina',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nombre',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              rutina.nombre,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 20),
            Text(
              'Descripción',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              rutina.descripcion,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
            Text(
              'Objetivo',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              rutina.objetivo,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
            Text(
              'Pasos',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            ...rutina.pasos.entries.map((entry) {
              return Row(
                children: [
                  Icon(
                    entry.value ? Icons.check_circle : Icons.cancel,
                    color: entry.value ? Colors.green : Colors.red,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      entry.key,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              );
            }),
            const SizedBox(height: 20),
            Text(
              'Resultados Esperados',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              rutina.resultadosEsperados,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
      perfiles: perfiles,
      juegos: [],
    );
  }
}
