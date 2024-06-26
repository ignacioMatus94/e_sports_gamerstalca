import 'package:flutter/material.dart';
import '../models/juego.dart';
import '../models/perfil.dart';

class DrawerClase {
  static Widget buildScaffold({
    required BuildContext context,
    required String title,
    required Widget body,
    required Perfil perfil,
    required List<Perfil> perfiles,
    required List<Juego> juegos,
    List<Widget>? actions,
  }) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: actions,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: const Text(
                'E-Sports Gamerstalca',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            _buildDrawerItem(context, Icons.home, 'Home', () => Navigator.pushReplacementNamed(context, '/home')),
            _buildDrawerItem(context, Icons.games, 'Listado de Juegos', () => Navigator.pushReplacementNamed(context, '/juegos')),
            _buildDrawerItem(context, Icons.fitness_center, 'Seleccionar Rutina', () => Navigator.pushNamed(context, '/seleccionar_rutina')),
            _buildDrawerItem(context, Icons.person, 'Perfil', () => Navigator.pushReplacementNamed(context, '/perfil')),
            _buildDrawerItem(context, Icons.history, 'Historial de Avances', () => Navigator.pushNamed(context, '/historial')),
            _buildDrawerItem(context, Icons.settings, 'Configuración', () => Navigator.pushReplacementNamed(context, '/configuracion')),
          ],
        ),
      ),
      body: body,
    );
  }

  static Widget _buildDrawerItem(BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }
}
