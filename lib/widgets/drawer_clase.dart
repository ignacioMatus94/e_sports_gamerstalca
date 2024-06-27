import 'package:flutter/material.dart';
import '../models/perfil.dart';
import '../models/juego.dart';

class DrawerClase extends StatelessWidget {
  final Perfil perfil;
  final List<Perfil> perfiles;
  final List<Juego> juegos;

  const DrawerClase({
    super.key,
    required this.perfil,
    required this.perfiles,
    required this.juegos,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(perfil.nombre),
            accountEmail: Text('user@example.com'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage(perfil.avatarUrl),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Inicio'),
            onTap: () {
              Navigator.pushNamed(context, '/home');
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Perfil'),
            onTap: () {
              Navigator.pushNamed(context, '/perfil');
            },
          ),
          ListTile(
            leading: Icon(Icons.gamepad),
            title: Text('Juegos'),
            onTap: () {
              Navigator.pushNamed(context, '/juegos');
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Configuración'),
            onTap: () {
              Navigator.pushNamed(context, '/configuracion');
            },
          ),
        ],
      ),
    );
  }

  static Scaffold buildScaffold({
    required BuildContext context,
    required String title,
    required Widget body,
    required Perfil perfil,
    required List<Perfil> perfiles,
    required List<Juego> juegos,
  }) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      drawer: DrawerClase(perfil: perfil, perfiles: perfiles, juegos: juegos),
      body: body,
    );
  }
}
