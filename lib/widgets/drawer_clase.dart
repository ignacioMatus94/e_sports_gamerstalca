import 'package:flutter/material.dart';
import '../models/profile.dart';
import '../models/game.dart';

class AppDrawer extends StatelessWidget {
  final Profile profile;
  final List<Game> games;

  const AppDrawer({
    Key? key,
    required this.profile,
    required this.games,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(profile.name),
            accountEmail: Text(profile.email),
            currentAccountPicture: CircleAvatar(
              child: Text(profile.name[0]), // Mostrando la primera letra del nombre como avatar
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Inicio'),
            onTap: () {
              Navigator.pushNamed(context, '/home', arguments: {
                'profile': profile,
                'games': games,
              });
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Perfil'),
            onTap: () {
              Navigator.pushNamed(context, '/perfil', arguments: {
                'profile': profile,
                'games': games,
              });
            },
          ),
          ListTile(
            leading: Icon(Icons.gamepad),
            title: Text('Juegos'),
            onTap: () {
              Navigator.pushNamed(context, '/juegos', arguments: {
                'profile': profile,
                'games': games,
              });
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Configuración'),
            onTap: () {
              Navigator.pushNamed(context, '/configuracion', arguments: {
                'profile': profile,
                'games': games,
              });
            },
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: Text('Seleccionar Rutina'),
            onTap: () {
              Navigator.pushNamed(context, '/seleccionar_rutina', arguments: {
                'profile': profile,
                'games': games,
              });
            },
          ),
          ListTile(
            leading: Icon(Icons.history),
            title: Text('Historial de Avances'),
            onTap: () {
              Navigator.pushNamed(context, '/historial', arguments: {
                'profile': profile,
                'games': games,
              });
            },
          ),
          ListTile(
            leading: Icon(Icons.bar_chart),
            title: Text('Registrar Avance'),
            onTap: () {
              Navigator.pushNamed(context, '/avance', arguments: {
                'profile': profile,
                'games': games,
              });
            },
          ),
        ],
      ),
    );
  }
}
