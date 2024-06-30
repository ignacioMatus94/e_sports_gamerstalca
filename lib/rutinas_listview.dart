import 'package:flutter/material.dart';
import '../models/juego.dart';
import '../models/rutina.dart';
import 'rutina_card.dart';

class RutinasListView extends StatelessWidget {
  final List<Juego> juegos;
  final Map<int, Rutina?> rutinasSeleccionadas;
  final void Function(int, Rutina) guardarRutinaSeleccionada;
  final Future<void> Function(BuildContext) reiniciarBaseDeDatos;

  const RutinasListView({
    super.key,
    required this.juegos,
    required this.rutinasSeleccionadas,
    required this.guardarRutinaSeleccionada,
    required this.reiniciarBaseDeDatos,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: juegos.length,
            itemBuilder: (context, index) {
              final juego = juegos[index];
              final rutinaSeleccionada = rutinasSeleccionadas[juego.id];
              return RutinaCard(
                juego: juego,
                rutinaSeleccionada: rutinaSeleccionada,
                onRutinaSelected: guardarRutinaSeleccionada,
              );
            },
          ),
        ),
        ElevatedButton(
          onPressed: () => reiniciarBaseDeDatos(context),
          child: const Text('Eliminar base de datos y reiniciar con rutinas iniciales'),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
