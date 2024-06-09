import 'package:flutter/material.dart';
import 'listado_juegos.dart';
import 'pantalla_configuracion.dart';
import 'pantalla_perfil.dart';
import 'pantalla_recordatorio.dart';
import 'pantalla_rutinas.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _indiceSeleccionado = 0;

  void _alSeleccionarElemento(int indice) {
    setState(() {
      _indiceSeleccionado = indice;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> opcionesWidget = [
      PaginaResumen(navegarA: _alSeleccionarElemento),
      const PantallaListadoJuegos(),
      const PantallaRutinasEntrenamiento(),
      const PantallaRecordatorios(),
      const PantallaPerfil(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'E_SPORT_GAMERSTALCA',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PantallaConfiguracion()),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade100, Colors.blue.shade300],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: opcionesWidget.elementAt(_indiceSeleccionado),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Resumen',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.games),
            label: 'Juegos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Rutinas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Recordatorios',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        currentIndex: _indiceSeleccionado,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.secondary,
        onTap: _alSeleccionarElemento,
      ),
    );
  }
}

class PaginaResumen extends StatelessWidget {
  final Function(int) navegarA;

  const PaginaResumen({super.key, required this.navegarA});

  Widget _construirTarjetaResumen(BuildContext context, String titulo, String descripcion, IconData icono, int indice) {
    return GestureDetector(
      onTap: () {
        navegarA(indice);
      },
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Container(
          height: 140,
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icono, color: Theme.of(context).colorScheme.primary, size: 60),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      titulo,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      descripcion,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward, size: 30),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _construirTarjetaResumen(context, 'Principal', 'Detalles de los juegos disponibles', Icons.games, 1),
        _construirTarjetaResumen(context, 'Rutinas', 'Mejora tu precisión y tiempo de reacción', Icons.fitness_center, 2),
        _construirTarjetaResumen(context, 'Recordatorios', 'No olvides tus tareas importantes', Icons.notifications, 3),
        _construirTarjetaResumen(context, 'Perfil', 'Información de tu perfil y estadísticas', Icons.person, 4),
      ],
    );
  }
}
