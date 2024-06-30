import 'package:flutter/material.dart';
import 'services/database_service.dart';
import 'obtener_juegos.dart';
import 'screens/home.dart';
import 'screens/pantalla_juegos.dart';
import 'screens/pantalla_perfil.dart';
import 'screens/pantalla_configuracion.dart';
import 'screens/pantalla_historial_avances.dart';
import 'screens/pantalla_seleccionar_rutina.dart';
import 'screens/pantalla_avance.dart';
import 'models/juego.dart';
import 'models/perfil.dart';
import 'models/rutina.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DatabaseService().initializeDatabase();

  final juegos = obtenerJuegos();
  await DatabaseService().insertarRutinasIniciales(juegos);

  final perfiles = [Perfil(id: 1, nombre: 'Usuario', avatarUrl: 'assets/profile_picture.png')];
  final rutinasSeleccionadas = <int, Rutina>{};

  runApp(MyApp(juegos: juegos, perfiles: perfiles, rutinasSeleccionadas: rutinasSeleccionadas));
}

class MyApp extends StatelessWidget {
  final List<Juego> juegos;
  final List<Perfil> perfiles;
  final Map<int, Rutina> rutinasSeleccionadas;

  const MyApp({
    super.key,
    required this.juegos,
    required this.perfiles,
    required this.rutinasSeleccionadas,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestión de Rutinas',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Home(juegos: juegos, perfiles: perfiles, rutinasSeleccionadas: rutinasSeleccionadas),
        '/home': (context) => Home(juegos: juegos, perfiles: perfiles, rutinasSeleccionadas: rutinasSeleccionadas),
        '/juegos': (context) => PantallaJuegos(juegos: juegos, perfiles: perfiles),
        '/perfil': (context) => PantallaPerfil(perfiles: perfiles, juegos: juegos, rutinasSeleccionadas: rutinasSeleccionadas),
        '/configuracion': (context) => PantallaConfiguracion(perfiles: perfiles),
        '/historial': (context) => PantallaHistorialAvances(rutina: juegos[0].rutinas[0], perfiles: perfiles, juegos: juegos, rutinasSeleccionadas: rutinasSeleccionadas),
        '/seleccionar_rutina': (context) => PantallaSeleccionarRutina(juegos: juegos, perfiles: perfiles, rutinasSeleccionadas: rutinasSeleccionadas),
        '/avance': (context) => PantallaAvance(rutinasSeleccionadas: rutinasSeleccionadas, perfiles: perfiles, juegos: juegos),
      },
    );
  }
}
