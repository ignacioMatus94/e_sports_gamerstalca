import 'package:flutter/material.dart';
import '../models/juego.dart';
import '../models/perfil.dart';
import '../constants/colors.dart';
import '../widgets/drawer_clase.dart';

class Home extends StatelessWidget {
  final List<Juego> juegos;
  final Perfil perfil;
  final List<Perfil> perfiles;

  const Home({
    super.key,
    required this.juegos,
    required this.perfil,
    required this.perfiles,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home', style: TextStyle(color: titleTextColor)),
        backgroundColor: appBarColor,
      ),
      drawer: DrawerClase(
        perfil: perfil,
        perfiles: perfiles,
        juegos: juegos,
      ),
      body: Container(
        color: backgroundColor,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Bienvenido, ${perfil.nombre}',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.purple),
                ),
                const SizedBox(height: 20),
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  children: <Widget>[
                    _buildMenuItem(
                      context,
                      icon: Icons.videogame_asset,
                      label: 'Ver Juegos',
                      route: '/juegos',
                    ),
                    _buildMenuItem(
                      context,
                      icon: Icons.person,
                      label: 'Ver Perfil',
                      route: '/perfil',
                    ),
                    _buildMenuItem(
                      context,
                      icon: Icons.settings,
                      label: 'Configuración',
                      route: '/configuracion',
                    ),
                    _buildMenuItem(
                      context,
                      icon: Icons.history,
                      label: 'Historial de Avances',
                      route: '/historial',
                    ),
                    _buildMenuItem(
                      context,
                      icon: Icons.list,
                      label: 'Seleccionar Rutina',
                      route: '/seleccionar_rutina',
                    ),
                    _buildMenuItem(
                      context,
                      icon: Icons.bar_chart,
                      label: 'Registrar Avance',
                      onTap: () {
                        // Lógica para navegar a la pantalla de avance
                        Navigator.pushNamed(context, '/avance', arguments: {
                          'rutina': juegos[0].rutinas[0], // Ajusta esto según sea necesario
                          'perfil': perfil,
                          'perfiles': perfiles,
                          'juegos': juegos,
                        });
                      },
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

  Widget _buildMenuItem(BuildContext context, {required IconData icon, required String label, String? route, VoidCallback? onTap}) {
    return Card(
      color: Colors.purple,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: InkWell(
        onTap: onTap ?? () {
          if (route != null) {
            Navigator.pushNamed(context, route);
          }
        },
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(icon, size: 50, color: Colors.white),
              const SizedBox(height: 10),
              Text(
                label,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
