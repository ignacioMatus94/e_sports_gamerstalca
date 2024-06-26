import 'package:flutter/material.dart';
import '../models/rutina.dart';
import '../models/perfil.dart';
import '../widgets/drawer_clase.dart';

class PantallaDetalleRutina extends StatelessWidget {
  final Rutina rutina;
  final Perfil perfil;
  final List<Perfil> perfiles;

  const PantallaDetalleRutina({
    super.key,
    required this.rutina,
    required this.perfil,
    required this.perfiles,
  });

  @override
  Widget build(BuildContext context) {
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
            Text(
              rutina.pasos,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
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
      perfil: perfil,
      perfiles: perfiles,
      juegos: [],
    );
  }
}
