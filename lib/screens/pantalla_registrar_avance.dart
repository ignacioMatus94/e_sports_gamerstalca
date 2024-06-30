import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/avance.dart';
import '../models/perfil.dart';
import '../models/rutina.dart';
import '../services/database_service.dart';

class PantallaRegistrarAvance extends StatefulWidget {
  final List<Perfil> perfiles;
  final Rutina rutina;

  const PantallaRegistrarAvance({
    Key? key,
    required this.perfiles,
    required this.rutina,
  }) : super(key: key);

  @override
  _PantallaRegistrarAvanceState createState() => _PantallaRegistrarAvanceState();
}

class _PantallaRegistrarAvanceState extends State<PantallaRegistrarAvance> {
  final TextEditingController _progresoController = TextEditingController();

  void _registrarAvance() async {
    final perfil = widget.perfiles.first;
    final int progreso = int.parse(_progresoController.text);
    final Avance avance = Avance(
      id: null,
      perfilId: perfil.id,
      rutinaId: widget.rutina.id,
      juegoId: widget.rutina.juegoId,
      nombre: widget.rutina.nombre,
      descripcion: widget.rutina.descripcion,
      objetivo: widget.rutina.objetivo,
      pasos: widget.rutina.pasos,
      resultadosEsperados: widget.rutina.resultadosEsperados,
      dificultad: widget.rutina.dificultad,
      puntuacion: widget.rutina.puntuacion,
      fecha: DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
      progreso: progreso,
    );

    await DatabaseService().insertAvance(avance);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registrar Avance')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Rutina: ${widget.rutina.nombre}'),
            TextField(
              controller: _progresoController,
              decoration: InputDecoration(labelText: 'Progreso'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: _registrarAvance,
              child: const Text('Registrar'),
            ),
          ],
        ),
      ),
    );
  }
}
