import 'package:flutter/material.dart';
import '../models/avance.dart';
import '../models/juego.dart';
import '../models/rutina.dart';

class AvanceListView extends StatelessWidget {
  final List<Juego> juegos;
  final Map<int, List<Avance>> avancesMap;
  final List<Rutina> rutinasSeleccionadas;

  const AvanceListView({
    Key? key,
    required this.juegos,
    required this.avancesMap,
    required this.rutinasSeleccionadas,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: juegos.length,
      itemBuilder: (context, index) {
        final juego = juegos[index];
        final rutinaSeleccionada = rutinasSeleccionadas.firstWhere(
          (rutina) => rutina.juegoId == juego.id,
          orElse: () => Rutina(
            id: 0,
            nombre: 'Ninguna',
            descripcion: '',
            objetivo: '',
            pasos: {},
            resultadosEsperados: '',
            dificultad: '',
            puntuacion: 0,
            juegoId: juego.id,
          ),
        );
        final avances = avancesMap[rutinaSeleccionada.id] ?? [];

        return ExpansionTile(
          title: Text(juego.nombre),
          subtitle: Text('Rutina: ${rutinaSeleccionada.nombre}'),
          children: avances.map((avance) {
            return ListTile(
              title: Text(avance.nombre),
              subtitle: Text('Progreso: ${avance.progreso}%'),
            );
          }).toList(),
        );
      },
    );
  }
}
