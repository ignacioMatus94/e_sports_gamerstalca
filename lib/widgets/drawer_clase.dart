import 'package:flutter/material.dart';
import '../models/perfil.dart';
import '../models/juego.dart';

class DrawerClase extends StatelessWidget {
  final List<Perfil> perfiles;
  final List<Juego> juegos;

  const DrawerClase({
    Key? key,
    required this.perfiles,
    required this.juegos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final perfilActual = perfiles.first;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(perfilActual.nombre),
            accountEmail: Text('user@example.com'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage(perfilActual.avatarUrl),
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
          ListTile(
            leading: Icon(Icons.list),
            title: Text('Seleccionar Rutina'),
            onTap: () {
              Navigator.pushNamed(context, '/seleccionar_rutina');
            },
          ),
          ListTile(
            leading: Icon(Icons.history),
            title: Text('Historial de Avances'),
            onTap: () {
              Navigator.pushNamed(context, '/historial');
            },
          ),
          ListTile(
            leading: Icon(Icons.bar_chart),
            title: Text('Registrar Avance'),
            onTap: () {
              Navigator.pushNamed(context, '/avance');
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
    required List<Perfil> perfiles,
    required List<Juego> juegos,
  }) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      drawer: DrawerClase(perfiles: perfiles, juegos: juegos),
      body: Container(
        color: Colors.white,
        child: body,
      ),
    );
  }
}
