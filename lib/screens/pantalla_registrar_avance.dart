import 'package:flutter/material.dart';
import '../models/perfil.dart';
import '../models/rutina.dart';
import '../models/avance.dart';
import '../services/database_service.dart';

class PantallaRegistrarAvance extends StatefulWidget {
  final Perfil perfil;
  final Rutina rutina;

  const PantallaRegistrarAvance({
    super.key,
    required this.perfil,
    required this.rutina,
  });

  @override
  _PantallaRegistrarAvanceState createState() => _PantallaRegistrarAvanceState();
}

class _PantallaRegistrarAvanceState extends State<PantallaRegistrarAvance> {
  final TextEditingController _progresoController = TextEditingController();

  void _registrarAvance() async {
    final int progreso = int.parse(_progresoController.text);
    final Avance avance = Avance(
      id: null,
      perfilId: widget.perfil.id!,
      rutinaId: widget.rutina.id!,
      fecha: DateTime.now(),
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
              child: Text('Registrar'),
            ),
          ],
        ),
      ),
    );
  }
}
