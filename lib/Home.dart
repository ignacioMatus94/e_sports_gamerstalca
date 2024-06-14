import 'package:flutter/material.dart';
import 'drawer_clase.dart';
import 'listado_juegos.dart';
import 'pantalla_perfil.dart';
import 'pantalla_recordatorio.dart';
import 'pantalla_rutinas.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;

  final List<Widget> pages = [
    const PaginaResumen(),
    const PantallaListadoJuegos(),
    const PantallaRutinasEntrenamiento(),
    const PantallaRecordatorios(),
    const PantallaPerfil(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return DrawerClase.buildScaffold(
      context,
      'E_SPORT_GAMERSTALCA',
      Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade100, Colors.blue.shade300],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: pages[selectedIndex],
      ),
    );
  }
}

class PaginaResumen extends StatelessWidget {
  const PaginaResumen({super.key});

  Widget construirTarjetaApp(BuildContext context, String titulo, IconData icono, String subtitulo) {
    return InkWell(
      onTap: () {
        logger.i('Tapped on $titulo');
      },
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Container(
          height: 140,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            gradient: LinearGradient(
              colors: [Colors.blue.withOpacity(0.7), Colors.purple.withOpacity(0.7)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Hero(
                  tag: titulo,
                  child: Icon(icono, color: Colors.white, size: 60),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          titulo,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Flexible(
                        child: Text(
                          subtitulo,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: Colors.white70,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    logger.i('build PaginaResumen');
    return SingleChildScrollView(
      child: Column(
        children: [
          GridView.count(
            crossAxisCount: 1,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16.0),
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            children: <Widget>[
              construirTarjetaApp(context, 'Principal', Icons.games, 'Detalles de los juegos disponibles'),
              construirTarjetaApp(context, 'Rutinas', Icons.fitness_center, 'Mejora tu precisión y tiempo de reacción'),
              construirTarjetaApp(context, 'Recordatorios', Icons.notifications, 'No olvides tus tareas importantes'),
              construirTarjetaApp(context, 'Perfil', Icons.person, 'Información de tu perfil y estadísticas'),
              construirTarjetaApp(context, 'Configuración', Icons.settings, 'Ajusta la app'),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
