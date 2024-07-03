import 'package:flutter/material.dart';
import 'package:e_sports_gamerstalca/services/database_service.dart';
import 'package:e_sports_gamerstalca/screens/progress_screen.dart';
import 'package:e_sports_gamerstalca/timer_service.dart';

class AppDrawer extends StatelessWidget {
  final DatabaseService _databaseService = DatabaseService();

  AppDrawer({super.key});

  Future<void> _navigateToProgressScreen(BuildContext context) async {
    try {
      final routines = await _databaseService.getRoutines();
      final selectedRoutines = routines.where((routine) => routine.selectedAt != null).toList();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProgressScreen(
            routines: selectedRoutines,
            timerService: TimerService(() {}),
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cargar las rutinas: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color primaryColor = theme.primaryColor;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: primaryColor,
            ),
            child: const Text(
              'Menú',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home, color: primaryColor),
            title: const Text(
              'Inicio',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              if (ModalRoute.of(context)?.settings.name != '/home') {
                Navigator.pop(context); // Cerrar el Drawer
                Navigator.pushReplacementNamed(context, '/home');
              } else {
                Navigator.pop(context); // Solo cierra el Drawer si ya está en Inicio
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.gamepad, color: primaryColor),
            title: const Text(
              'Juegos',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              if (ModalRoute.of(context)?.settings.name != '/details') {
                Navigator.pop(context); // Cerrar el Drawer
                Navigator.pushReplacementNamed(context, '/details');
              } else {
                Navigator.pop(context); // Solo cierra el Drawer si ya está en Juegos
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.show_chart, color: primaryColor),
            title: const Text(
              'Progreso',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.pop(context); // Cerrar el Drawer
              _navigateToProgressScreen(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.person, color: primaryColor),
            title: const Text(
              'Perfil',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              if (ModalRoute.of(context)?.settings.name != '/profile') {
                Navigator.pop(context); // Cerrar el Drawer
                Navigator.pushReplacementNamed(context, '/profile');
              } else {
                Navigator.pop(context); // Solo cierra el Drawer si ya está en Perfil
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.history, color: primaryColor),
            title: const Text(
              'Historial',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              if (ModalRoute.of(context)?.settings.name != '/history') {
                Navigator.pop(context); // Cerrar el Drawer
                Navigator.pushReplacementNamed(context, '/history');
              } else {
                Navigator.pop(context); // Solo cierra el Drawer si ya está en Historial
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.info, color: primaryColor),
            title: const Text(
              'Información de Juegos',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              if (ModalRoute.of(context)?.settings.name != '/gameInfo') {
                Navigator.pop(context); // Cerrar el Drawer
                Navigator.pushReplacementNamed(context, '/gameInfo');
              } else {
                Navigator.pop(context); // Solo cierra el Drawer si ya está en Información de Juegos
              }
            },
          ),
        ],
      ),
    );
  }
}
