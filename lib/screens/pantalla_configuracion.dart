import 'package:flutter/material.dart';
import '../models/perfil.dart'; // Asegúrate de que esta línea está incluida para importar la clase Perfil

class PantallaConfiguracion extends StatelessWidget {
  final Perfil perfil;

  const PantallaConfiguracion({super.key, required this.perfil});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configuración'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Otros botones o configuraciones pueden ir aquí
          ],
        ),
      ),
    );
  }
}
