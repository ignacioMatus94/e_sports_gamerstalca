import 'package:flutter/material.dart';

class PantallaAcceso extends StatelessWidget {
  // Añadir key al constructor
  const PantallaAcceso({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acceso'),
      ),
      body: const Center(
        child: Text('Pantalla de Acceso'),
      ),
    );
  }
}
