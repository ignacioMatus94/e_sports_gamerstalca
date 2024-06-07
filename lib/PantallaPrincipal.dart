import 'package:e_sports_gamerstalca/PantallaConfiguracion.dart';
import 'package:e_sports_gamerstalca/ProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:e_sports_gamerstalca/listado_juegos.dart';
import 'package:e_sports_gamerstalca/rutinas.dart';
import 'package:e_sports_gamerstalca/recordatorio.dart';

class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({super.key});

  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  int _selectedIndex = 0; // Índice para el elemento seleccionado en la barra de navegación

  // Lista de widgets que corresponden a cada opción en la barra de navegación
  static const List<Widget> _widgetOptions = <Widget>[
    PantallaListadoJuegos(),
    PantallaPerfil(),
    PantallaRutinasEntrenamiento(),
    PantallaRecordatorios(),
  ];

  // Actualizar el índice seleccionado al tocar un elemento en la barra de navegación
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('E_SPORT_GAMERSTALCA'),
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PantallaConfiguracion()),
              );
            },
          ),
        ],
      ),
      // Mostrar el widget correspondiente al índice seleccionado
      body: _widgetOptions.elementAt(_selectedIndex),
      backgroundColor: Theme.of(context).colorScheme.background,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.games),
            label: 'Juegos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Rutinas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Recordatorios',
          ),
        ],
        currentIndex: _selectedIndex, // El índice del elemento actualmente seleccionado
        selectedItemColor: Theme.of(context).colorScheme.primary, // Color del elemento seleccionado
        unselectedItemColor: Theme.of(context).colorScheme.secondary, // Color de los elementos no seleccionados
        onTap: _onItemTapped, // Callback cuando un elemento es tocado
      ),
    );
  }
}
