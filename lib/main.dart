import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/pantalla_perfil.dart';
import 'screens/pantalla_historial_avances.dart';
import 'screens/pantalla_seleccionar_rutina.dart';
import 'screens/pantalla_juegos.dart';
import 'screens/pantalla_configuracion.dart';
import 'screens/splash_screen.dart';
import 'models/perfil.dart';
import 'models/rutina.dart';
import 'models/juego.dart';
import 'services/database_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseService().initializeDatabase();

  final juegos = [
    Juego(
      id: 1,
      nombre: 'Super Mario',
      descripcion: 'Un juego clásico de plataformas',
      imagenUrl: 'assets/mario.png',
      genero: 'Plataformas',
      ano: 1985,
      desarrollador: 'Nintendo',
      link: 'https://www.nintendo.com/',
      puntuacion: 9.5,
      rutinas: [
        Rutina(
          id: 1,
          nombre: 'Fácil',
          descripcion: 'Una rutina fácil para principiantes',
          objetivo: 'Completar el primer mundo',
          pasos: 'Sigue los pasos del tutorial',
          resultadosEsperados: 'Aprender las mecánicas básicas',
          dificultad: 'Fácil',
        ),
        Rutina(
          id: 2,
          nombre: 'Media',
          descripcion: 'Una rutina de dificultad media',
          objetivo: 'Completar los primeros 3 mundos',
          pasos: 'Sigue las estrategias avanzadas',
          resultadosEsperados: 'Mejorar tus habilidades',
          dificultad: 'Media',
        ),
        Rutina(
          id: 3,
          nombre: 'Difícil',
          descripcion: 'Una rutina difícil para expertos',
          objetivo: 'Completar el juego sin morir',
          pasos: 'Sigue las estrategias de los expertos',
          resultadosEsperados: 'Convertirte en un maestro del juego',
          dificultad: 'Difícil',
        ),
      ],
    ),
    Juego(
      id: 2,
      nombre: 'Rayman',
      descripcion: 'Un juego de plataformas con hermosos gráficos',
      imagenUrl: 'assets/rayman.png',
      genero: 'Plataformas',
      ano: 1995,
      desarrollador: 'Ubisoft',
      link: 'https://www.ubisoft.com/',
      puntuacion: 9.0,
      rutinas: [
        Rutina(
          id: 4,
          nombre: 'Fácil',
          descripcion: 'Una rutina fácil para principiantes',
          objetivo: 'Completar el primer mundo',
          pasos: 'Sigue los pasos del tutorial',
          resultadosEsperados: 'Aprender las mecánicas básicas',
          dificultad: 'Fácil',
        ),
        Rutina(
          id: 5,
          nombre: 'Media',
          descripcion: 'Una rutina de dificultad media',
          objetivo: 'Completar los primeros 3 mundos',
          pasos: 'Sigue las estrategias avanzadas',
          resultadosEsperados: 'Mejorar tus habilidades',
          dificultad: 'Media',
        ),
        Rutina(
          id: 6,
          nombre: 'Difícil',
          descripcion: 'Una rutina difícil para expertos',
          objetivo: 'Completar el juego sin morir',
          pasos: 'Sigue las estrategias de los expertos',
          resultadosEsperados: 'Convertirte en un maestro del juego',
          dificultad: 'Difícil',
        ),
      ],
    ),
    Juego(
      id: 3,
      nombre: 'Starcraft',
      descripcion: 'Un juego de estrategia en tiempo real en el espacio',
      imagenUrl: 'assets/starcraft.png',
      genero: 'Estrategia en Tiempo Real',
      ano: 1998,
      desarrollador: 'Blizzard Entertainment',
      link: 'https://www.blizzard.com/',
      puntuacion: 9.5,
      rutinas: [
        Rutina(
          id: 7,
          nombre: 'Fácil',
          descripcion: 'Una rutina fácil para principiantes',
          objetivo: 'Ganar la primera campaña',
          pasos: 'Sigue los pasos del tutorial',
          resultadosEsperados: 'Aprender las mecánicas básicas',
          dificultad: 'Fácil',
        ),
        Rutina(
          id: 8,
          nombre: 'Media',
          descripcion: 'Una rutina de dificultad media',
          objetivo: 'Ganar tres campañas',
          pasos: 'Usa las estrategias avanzadas',
          resultadosEsperados: 'Mejorar tus habilidades',
          dificultad: 'Media',
        ),
        Rutina(
          id: 9,
          nombre: 'Difícil',
          descripcion: 'Una rutina difícil para expertos',
          objetivo: 'Ganar todas las campañas sin perder unidades clave',
          pasos: 'Sigue las estrategias de los expertos',
          resultadosEsperados: 'Convertirte en un maestro del juego',
          dificultad: 'Difícil',
        ),
      ],
    ),
    Juego(
      id: 4,
      nombre: 'Pacman',
      descripcion: 'Un juego clásico de laberintos',
      imagenUrl: 'assets/pacman.png',
      genero: 'Arcade',
      ano: 1980,
      desarrollador: 'Namco',
      link: 'https://www.bandainamcoent.com/',
      puntuacion: 8.5,
      rutinas: [
        Rutina(
          id: 10,
          nombre: 'Fácil',
          descripcion: 'Una rutina fácil para principiantes',
          objetivo: 'Completar el primer nivel',
          pasos: 'Sigue los pasos del tutorial',
          resultadosEsperados: 'Aprender las mecánicas básicas',
          dificultad: 'Fácil',
        ),
        Rutina(
          id: 11,
          nombre: 'Media',
          descripcion: 'Una rutina de dificultad media',
          objetivo: 'Completar los primeros 3 niveles',
          pasos: 'Sigue las estrategias avanzadas',
          resultadosEsperados: 'Mejorar tus habilidades',
          dificultad: 'Media',
        ),
        Rutina(
          id: 12,
          nombre: 'Difícil',
          descripcion: 'Una rutina difícil para expertos',
          objetivo: 'Completar el juego sin perder vidas',
          pasos: 'Sigue las estrategias de los expertos',
          resultadosEsperados: 'Convertirte en un maestro del juego',
          dificultad: 'Difícil',
        ),
      ],
    ),
  ];

  final perfil = Perfil(
    id: 1,
    nombre: 'Usuario',
    avatarUrl: 'assets/profile_picture.png',
  );

  final perfiles = [perfil];

  runApp(MyApp(juegos: juegos, perfil: perfil, perfiles: perfiles));
}

class MyApp extends StatelessWidget {
  final List<Juego> juegos;
  final Perfil perfil;
  final List<Perfil> perfiles;

  MyApp({required this.juegos, required this.perfil, required this.perfiles});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Sports Gamerstalca',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(
              perfil: perfil,
              perfiles: perfiles,
              juegos: juegos,
            ),
        '/home': (context) => Home(
              juegos: juegos,
              perfil: perfil,
              perfiles: perfiles,
            ),
        '/perfil': (context) => PantallaPerfil(
              perfil: perfil,
              perfiles: perfiles,
              juegos: juegos,
            ),
        '/seleccionar_rutina': (context) => PantallaSeleccionarRutina(
              juegos: juegos,
              perfil: perfil,
              perfiles: perfiles,
            ),
        '/configuracion': (context) => PantallaConfiguracion(
              perfil: perfil,
            ),
        '/juegos': (context) => PantallaJuegos(
              juegos: juegos,
              perfil: perfil,
              perfiles: perfiles,
            ),
        '/historial': (context) => PantallaHistorialAvances(
              rutina: juegos[0].rutinas[0],
              perfil: perfil,
              juegos: juegos,
            ),
      },
    );
  }
}
