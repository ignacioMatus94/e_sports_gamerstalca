import 'package:flutter/material.dart';
import '../models/juego.dart';
import '../models/perfil.dart';
import '../models/rutina.dart';
import '../screens/home.dart';
import '../screens/pantalla_perfil.dart';
import '../screens/pantalla_historial_avances.dart';
import '../screens/pantalla_seleccionar_rutina.dart';
import '../screens/pantalla_juegos.dart';
import '../screens/pantalla_configuracion.dart';

class RemoveDebugBanner extends StatelessWidget {
  final List<Juego> juegos;
  final Map<int, Rutina> rutinasSeleccionadas;

  const RemoveDebugBanner({
    super.key,
    required this.juegos,
    required this.rutinasSeleccionadas,
  });

  @override
  Widget build(BuildContext context) {
    final perfiles = [
      Perfil(
        id: 1,
        nombre: 'Usuario',
        avatarUrl: 'assets/profile_picture.png',
      ),
    ];

    return MaterialApp(
      title: 'E-Sports Gamerstalca',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: {
        '/home': (context) => Home(
              juegos: juegos,
              perfiles: perfiles,
              rutinasSeleccionadas: rutinasSeleccionadas,
            ),
        '/perfil': (context) => PantallaPerfil(
              perfiles: perfiles,
              juegos: juegos,
              rutinasSeleccionadas: rutinasSeleccionadas,
            ),
        '/seleccionar_rutina': (context) => PantallaSeleccionarRutina(
              juegos: juegos,
              perfiles: perfiles, rutinasSeleccionadas: {},
            ),
        '/configuracion': (context) => PantallaConfiguracion(
              perfiles: perfiles,
            ),
        '/juegos': (context) => PantallaJuegos(
              juegos: juegos,
              perfiles: perfiles,
            ),
        '/historial': (context) => PantallaHistorialAvances(
              rutina: juegos[0].rutinas[0],
              perfiles: perfiles,
              juegos: juegos,
              rutinasSeleccionadas: rutinasSeleccionadas,
            ),
      },
    );
  }
}
