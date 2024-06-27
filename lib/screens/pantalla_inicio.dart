import 'package:flutter/material.dart';
import '../models/perfil.dart';
import '../models/juego.dart';

class PantallaInicio extends StatelessWidget {
  final Perfil perfil;
  final List<Perfil> perfiles;
  final List<Juego> juegos;

  const PantallaInicio({
    super.key,
    required this.perfil,
    required this.perfiles,
    required this.juegos,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Bienvenido, ${perfil.nombreUsuario}', // Asegúrate de que esta referencia sea correcta
              style: TextStyle(fontSize: 24),
            ),
            // Otros widgets aquí...
          ],
        ),
      ),
    );
  }
}
