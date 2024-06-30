import 'package:flutter/material.dart';
import '../models/juego.dart';
import '../models/rutina.dart';

class JuegoCard extends StatelessWidget {
  final Juego juego;
  final Rutina? rutinaSeleccionada;
  final void Function(BuildContext, String, Rutina) mostrarRutinaSeleccionada;

  const JuegoCard({
    Key? key,
    required this.juego,
    required this.rutinaSeleccionada,
    required this.mostrarRutinaSeleccionada,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.deepPurple[200],
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        tileColor: Colors.purple[100],
        leading: Image.asset(juego.imagenUrl, width: 50, height: 50),
        title: Text(juego.nombre, style: TextStyle(color: Colors.deepPurple[900])),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Puntuación máxima del juego: 10', style: TextStyle(color: Colors.deepPurple[700])),
            rutinaSeleccionada != null
                ? Text('Rutina seleccionada: ${rutinaSeleccionada!.nombre} (Puntuación: ${rutinaSeleccionada!.puntuacion})', style: TextStyle(color: Colors.deepPurple[700]))
                : const Text('Sin rutinas seleccionadas'),
          ],
        ),
        trailing: Icon(
          rutinaSeleccionada != null ? Icons.check_circle : Icons.radio_button_unchecked,
          color: rutinaSeleccionada != null ? Theme.of(context).primaryColor : Colors.grey,
        ),
        onTap: () {
          if (rutinaSeleccionada != null) {
            mostrarRutinaSeleccionada(context, juego.nombre, rutinaSeleccionada!);
          }
        },
      ),
    );
  }
}
