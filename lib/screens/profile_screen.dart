import 'package:flutter/material.dart';
import '../services/database_service.dart';
import 'home_screen.dart';
import 'progress_screen.dart';
import '../timer_service.dart';
import '../app_drawer.dart'; // Asegúrate de importar AppDrawer

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<void> _navigateToProgress(BuildContext context) async {
    final DatabaseService databaseService = DatabaseService();
    final routines = await databaseService.getRoutines();
    final selectedRoutines = routines.where((routine) => routine.selectedAt != null).toList();

    if (!context.mounted) return; // Verifica si el contexto sigue montado antes de usarlo

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProgressScreen(
          routines: selectedRoutines,
          timerService: TimerService(() {}),
        ),
      ),
    );
  }

  void _navigateToHomeScreen(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      drawer: AppDrawer(), // Usar el Drawer aquí
      body: Center(
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          margin: const EdgeInsets.all(16.0),
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/profile_picture.png'),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: Colors.blueAccent,
                      size: 30,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Nombre: Ignacio Matus',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(
                      Icons.email,
                      color: Colors.greenAccent,
                      size: 30,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Correo: ignismatus94@gmail.com',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.orangeAccent,
                      size: 30,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Nivel: Avanzado',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(
                      Icons.score,
                      color: Colors.redAccent,
                      size: 30,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Puntos: 1000',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
