import 'package:flutter/material.dart';
import '../models/juego.dart';
import '../models/perfil.dart';
import '../screens/home.dart';
import '../screens/pantalla_perfil.dart';
import '../screens/pantalla_historial_avances.dart';
import '../screens/pantalla_seleccionar_rutina.dart';
import '../screens/pantalla_juegos.dart';
import '../screens/pantalla_configuracion.dart';

class RemoveDebugBanner extends StatelessWidget {
  final List<Juego> juegos;

  const RemoveDebugBanner({
    super.key,
    required this.juegos,
  });

  @override
  Widget build(BuildContext context) {
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
              perfil: Perfil(
                id: 1,
                nombre: 'Usuario',
                avatarUrl: 'assets/profile_picture.png',
              ),
              perfiles: [
                Perfil(
                  id: 1,
                  nombre: 'Usuario',
                  avatarUrl: 'assets/profile_picture.png',
                ),
              ],
            ),
        '/perfil': (context) => PantallaPerfil(
              perfil: Perfil(
                id: 1,
                nombre: 'Usuario',
                avatarUrl: 'assets/profile_picture.png',
              ),
              perfiles: [
                Perfil(
                  id: 1,
                  nombre: 'Usuario',
                  avatarUrl: 'assets/profile_picture.png',
                ),
              ],
              juegos: juegos,
            ),
        '/seleccionar_rutina': (context) => PantallaSeleccionarRutina(
              juegos: juegos,
              perfil: Perfil(
                id: 1,
                nombre: 'Usuario',
                avatarUrl: 'assets/profile_picture.png',
              ),
              perfiles: [
                Perfil(
                  id: 1,
                  nombre: 'Usuario',
                  avatarUrl: 'assets/profile_picture.png',
                ),
              ],
            ),
        '/configuracion': (context) => PantallaConfiguracion(
              perfil: Perfil(
                id: 1,
                nombre: 'Usuario',
                avatarUrl: 'assets/profile_picture.png',
              ),
            ),
        '/juegos': (context) => PantallaJuegos(
              juegos: juegos,
              perfil: Perfil(
                id: 1,
                nombre: 'Usuario',
                avatarUrl: 'assets/profile_picture.png',
              ),
              perfiles: [
                Perfil(
                  id: 1,
                  nombre: 'Usuario',
                  avatarUrl: 'assets/profile_picture.png',
                ),
              ],
            ),
        '/historial': (context) => PantallaHistorialAvances(
              rutina: juegos[0].rutinas[0],
              perfil: Perfil(
                id: 1,
                nombre: 'Usuario',
                avatarUrl: 'assets/profile_picture.png',
              ),
              juegos: juegos,
            ),
      },
    );
  }
}
