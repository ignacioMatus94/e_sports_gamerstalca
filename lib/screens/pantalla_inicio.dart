import 'package:flutter/material.dart';
import '../models/perfil.dart';
import '../models/juego.dart';
import '../widgets/drawer_clase.dart';

class PantallaInicio extends StatelessWidget {
  final Perfil perfil;
  final List<Perfil> perfiles;
  final List<Juego> juegos;

  const PantallaInicio({super.key, required this.perfil, required this.perfiles, required this.juegos});

  @override
  Widget build(BuildContext context) {
    return DrawerClase.buildScaffold(
      context: context,
      title: 'Pantalla de Inicio',
      body: Center(
        child: Text(
          'Bienvenido, ${perfil.nombreUsuario}',
          style: const TextStyle(fontSize: 24),
        ),
      ),
      perfil: perfil,
      perfiles: perfiles,
      juegos: juegos,
    );
  }
}
