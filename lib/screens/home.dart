import 'package:flutter/material.dart';
import '../models/juego.dart';
import '../models/perfil.dart';
import '../widgets/drawer_clase.dart';

class Home extends StatelessWidget {
  final List<Juego> juegos;
  final Perfil perfil;
  final List<Perfil> perfiles;

  Home({required this.juegos, required this.perfil, required this.perfiles});

  @override
  Widget build(BuildContext context) {
    return DrawerClase.buildScaffold(
      context: context,
      title: 'Home',
      body: Center(
        child: Text('Bienvenido a E-Sports Gamerstalca'),
      ),
      perfil: perfil,
      perfiles: perfiles,
      juegos: juegos,
    );
  }
}
