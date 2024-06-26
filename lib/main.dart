import 'package:flutter/material.dart';
import 'models/juego.dart';
import 'models/rutina.dart';
import 'models/perfil.dart';
import 'screens/home.dart';
import 'screens/pantalla_juegos.dart';
import 'screens/pantalla_configuracion.dart';
import 'screens/pantalla_seleccionar_rutina.dart';
import 'screens/pantalla_perfil.dart'; // Asegúrate de tener este archivo

// Definimos las rutinas
List<Rutina> rutinasMario = [
  Rutina(
    id: 1,
    nombre: 'Rutina 1',
    descripcion: 'Mejora tu precisión en los saltos',
    objetivo: 'Desarrollar habilidades de salto y precisión',
    pasos: '1. Saltar 100 veces\n2. Practicar en plataformas pequeñas',
    resultadosEsperados: 'Mayor precisión en los saltos',
    dificultad: 'Fácil',
  ),
  Rutina(
    id: 2,
    nombre: 'Rutina 2',
    descripcion: 'Aumenta tu tiempo de reacción en plataformas',
    objetivo: 'Mejorar el tiempo de reacción',
    pasos: '1. Saltar entre plataformas en movimiento\n2. Evitar obstáculos',
    resultadosEsperados: 'Mejor tiempo de reacción',
    dificultad: 'Media',
  ),
];

List<Rutina> rutinasRayman = [
  Rutina(
    id: 1,
    nombre: 'Rutina 1',
    descripcion: 'Aumenta tu velocidad',
    objetivo: 'Desarrollar velocidad y agilidad',
    pasos: '1. Correr 5 km\n2. Practicar sprint',
    resultadosEsperados: 'Mayor velocidad y resistencia',
    dificultad: 'Media',
  ),
  Rutina(
    id: 2,
    nombre: 'Rutina 2',
    descripcion: 'Mejora tu precisión',
    objetivo: 'Desarrollar habilidades de precisión',
    pasos: '1. Disparar a objetivos\n2. Practicar puntería',
    resultadosEsperados: 'Mayor precisión',
    dificultad: 'Difícil',
  ),
];

List<Rutina> rutinasPacman = [
  Rutina(
    id: 1,
    nombre: 'Rutina 1',
    descripcion: 'Mejora tu estrategia',
    objetivo: 'Desarrollar habilidades estratégicas',
    pasos: '1. Planear movimientos\n2. Evitar fantasmas',
    resultadosEsperados: 'Mejor estrategia y planificación',
    dificultad: 'Fácil',
  ),
  Rutina(
    id: 2,
    nombre: 'Rutina 2',
    descripcion: 'Aumenta tu velocidad',
    objetivo: 'Desarrollar velocidad y reflejos',
    pasos: '1. Jugar a mayor velocidad\n2. Evitar fantasmas rápidamente',
    resultadosEsperados: 'Mayor velocidad y reflejos',
    dificultad: 'Media',
  ),
];

List<Rutina> rutinasStarcraft = [
  Rutina(
    id: 1,
    nombre: 'Rutina 1',
    descripcion: 'Mejora tu microgestión',
    objetivo: 'Desarrollar habilidades de microgestión',
    pasos: '1. Controlar unidades individualmente\n2. Practicar tácticas avanzadas',
    resultadosEsperados: 'Mayor control y eficacia',
    dificultad: 'Difícil',
  ),
  Rutina(
    id: 2,
    nombre: 'Rutina 2',
    descripcion: 'Aumenta tu estrategia',
    objetivo: 'Desarrollar habilidades estratégicas',
    pasos: '1. Planear estrategias\n2. Ejercer control de mapa',
    resultadosEsperados: 'Mejor planificación y control',
    dificultad: 'Media',
  ),
];

// Lista de juegos con sus respectivas rutinas
List<Juego> juegos = [
  Juego(
    id: 1,
    nombre: 'Mario',
    imagenUrl: 'assets/mario.png',
    genero: 'Plataforma',
    ano: 1985,
    desarrollador: 'Nintendo',
    descripcion: 'Juego clásico de plataformas.',
    link: 'https://mario.nintendo.com/es/',
    puntuacion: 10,
    rutinas: rutinasMario,
  ),
  Juego(
    id: 2,
    nombre: 'Rayman',
    imagenUrl: 'assets/rayman.png',
    genero: 'Plataforma',
    ano: 1995,
    desarrollador: 'Ubisoft',
    descripcion: 'Juego de plataformas con Rayman.',
    link: 'https://www.ubisoft.com/es-es/game/rayman/origins',
    puntuacion: 9,
    rutinas: rutinasRayman,
  ),
  Juego(
    id: 3,
    nombre: 'Pacman',
    imagenUrl: 'assets/pacman.png',
    genero: 'Arcade',
    ano: 1980,
    desarrollador: 'Namco',
    descripcion: 'Juego clásico de arcade.',
    link: 'https://www.pacman.com/en/',
    puntuacion: 8,
    rutinas: rutinasPacman,
  ),
  Juego(
    id: 4,
    nombre: 'Starcraft',
    imagenUrl: 'assets/starcraft.png',
    genero: 'Estrategia',
    ano: 1998,
    desarrollador: 'Blizzard',
    descripcion: 'Juego de estrategia en tiempo real.',
    link: 'https://starcraft2.blizzard.com/es-es/',
    puntuacion: 10,
    rutinas: rutinasStarcraft,
  ),
];

List<Perfil> perfiles = [
  Perfil(
    id: 1,
    nombreUsuario: 'Usuario1',
    email: 'usuario1@example.com',
    avatarUrl: 'assets/profile_picture.png',
    nivel: 1,
    puntos: 0,
  ),
  Perfil(
    id: 2,
    nombreUsuario: 'Usuario2',
    email: 'usuario2@example.com',
    avatarUrl: 'assets/profile_picture.png',
    nivel: 2,
    puntos: 100,
  ),
];

// Main function
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Sports Gamerstalca',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context) => Home(juegos: juegos, perfil: perfiles[0], perfiles: perfiles),
        '/juegos': (context) => PantallaJuegos(juegos: juegos, perfil: perfiles[0], perfiles: perfiles),
        '/seleccionar_rutina': (context) => PantallaSeleccionarRutina(perfil: perfiles[0], perfiles: perfiles, juegos: juegos),
        '/configuracion': (context) => PantallaConfiguracion(perfil: perfiles[0], perfiles: perfiles, juegos: juegos),
        '/perfil': (context) => PantallaPerfil(perfil: perfiles[0], perfiles: perfiles, juegos: juegos),
        // Añade las demás rutas necesarias aquí
      },
    );
  }
}
