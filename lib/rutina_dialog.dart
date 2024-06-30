import 'package:flutter/material.dart';
import '../models/rutina.dart';

class RutinaDialog extends StatelessWidget {
  final String juegoNombre;
  final Rutina rutina;

  const RutinaDialog({
    Key? key,
    required this.juegoNombre,
    required this.rutina,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.purple[100],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      title: Text('Detalles de:  $juegoNombre', style: TextStyle(color: Colors.deepPurple[900])),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRow(Icons.fitness_center, 'Nombre: $juegoNombre', context),
            _buildRow(Icons.description, 'Descripción: ${rutina.descripcion}', context),
            _buildRow(Icons.flag, 'Objetivo: ${rutina.objetivo}', context),
            _buildRow(Icons.list, 'Pasos: ${rutina.pasos}', context),
            _buildRow(Icons.check_circle, 'Resultados esperados: ${rutina.resultadosEsperados}', context),
            _buildRow(Icons.verified, 'Dificultad: ${rutina.dificultad}', context),
            _buildRow(Icons.star, 'Puntuación: ${rutina.puntuacion}', context),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('OK', style: TextStyle(color: Colors.deepPurple)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  Widget _buildRow(IconData icon, String text, BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.deepPurple[900]),
        SizedBox(width: 10),
        Expanded(
          child: Text(text, style: TextStyle(color: Colors.deepPurple[900])),
        ),
      ],
    );
  }
}
