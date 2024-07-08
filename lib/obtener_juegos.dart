import 'dart:convert';
import 'package:e_sports_gamerstalca/models/routine.dart';
import 'package:e_sports_gamerstalca/models/game.dart';

List<Game> obtenerJuegos() {
  return [
    Game(
      id: 1,
      name: 'Super Mario',
      description: 'Un juego clásico de plataformas',
      imageUrl: 'assets/mario.png',
      genre: 'Plataformas',
      year: 1985,
      developer: 'Nintendo',
      link: 'https://mario.nintendo.com/es/',
      rating: 9.5,
      routines: [
        Routine(
          id: 1,
          name: 'Fácil',
          description: 'Una rutina fácil para principiantes',
          objective: 'Completar el primer mundo',
          steps: jsonEncode({
            'Salta sobre los Goombas': false,
            'Recoge los power-ups': false,
            'Completa el nivel': false,
          }),
          expectedResults: 'Aprender las mecánicas básicas',
          difficulty: 'Fácil',
          rating: 6.0,
          gameId: 1,
          imageUrl: 'assets/mario.png',
        ),
        Routine(
          id: 2,
          name: 'Media',
          description: 'Una rutina de dificultad media',
          objective: 'Completar los primeros 3 mundos',
          steps: jsonEncode({
            'Encuentra todas las monedas escondidas': false,
            'Evita las trampas': false,
            'Derrota a los jefes de cada mundo': false,
          }),
          expectedResults: 'Mejorar tus habilidades',
          difficulty: 'Media',
          rating: 7.0,
          gameId: 1,
          imageUrl: 'assets/mario.png',
        ),
        Routine(
          id: 3,
          name: 'Difícil',
          description: 'Una rutina difícil para expertos',
          objective: 'Completar el juego sin morir',
          steps: jsonEncode({
            'Memoriza los patrones enemigos': false,
            'Usa las habilidades avanzadas de salto': false,
            'Completa los niveles en tiempo récord': false,
          }),
          expectedResults: 'Convertirte en un maestro del juego',
          difficulty: 'Difícil',
          rating: 8.0,
          gameId: 1,
          imageUrl: 'assets/mario.png',
        ),
      ],
    ),
    Game(
      id: 2,
      name: 'Rayman',
      description: 'Un juego de plataformas con hermosos gráficos',
      imageUrl: 'assets/rayman.png',
      genre: 'Plataformas',
      year: 1995,
      developer: 'Ubisoft',
      link: 'https://www.ubisoft.com/es-es/game/rayman/origins',
      rating: 9.0,
      routines: [
        Routine(
          id: 4,
          name: 'Fácil',
          description: 'Una rutina fácil para principiantes',
          objective: 'Completar el primer mundo',
          steps: jsonEncode({
            'Recoge todos los lums': false,
            'Derrota a los enemigos básicos': false,
            'Usa las habilidades de salto y puñetazo': false,
          }),
          expectedResults: 'Aprender las mecánicas básicas',
          difficulty: 'Fácil',
          rating: 6.0,
          gameId: 2,
          imageUrl: 'assets/rayman.png',
        ),
        Routine(
          id: 5,
          name: 'Media',
          description: 'Una rutina de dificultad media',
          objective: 'Completar los primeros 3 mundos',
          steps: jsonEncode({
            'Encuentra las jaulas escondidas': false,
            'Derrota a los mini-jefes': false,
            'Usa las habilidades avanzadas para superar obstáculos': false,
          }),
          expectedResults: 'Mejorar tus habilidades',
          difficulty: 'Media',
          rating: 7.0,
          gameId: 2,
          imageUrl: 'assets/rayman.png',
        ),
        Routine(
          id: 6,
          name: 'Difícil',
          description: 'Una rutina difícil para expertos',
          objective: 'Completar el juego sin morir',
          steps: jsonEncode({
            'Memoriza los patrones enemigos': false,
            'Usa las habilidades combinadas para moverte rápido': false,
            'Completa los niveles en tiempo récord': false,
          }),
          expectedResults: 'Convertirte en un maestro del juego',
          difficulty: 'Difícil',
          rating: 8.0,
          gameId: 2,
          imageUrl: 'assets/rayman.png',
        ),
      ],
    ),
    Game(
      id: 3,
      name: 'Starcraft',
      description: 'Un juego de estrategia en tiempo real en el espacio',
      imageUrl: 'assets/starcraft.png',
      genre: 'Estrategia en Tiempo Real',
      year: 1998,
      developer: 'Blizzard Entertainment',
      link: 'https://starcraft2.blizzard.com',
      rating: 9.5,
      routines: [
        Routine(
          id: 7,
          name: 'Fácil',
          description: 'Una rutina fácil para principiantes',
          objective: 'Ganar la primera campaña',
          steps: jsonEncode({
            'Construye una base sólida': false,
            'Recolecta recursos': false,
            'Entrena unidades básicas': false,
          }),
          expectedResults: 'Aprender las mecánicas básicas',
          difficulty: 'Fácil',
          rating: 6.0,
          gameId: 3,
          imageUrl: 'assets/starcraft.png',
        ),
        Routine(
          id: 8,
          name: 'Media',
          description: 'Una rutina de dificultad media',
          objective: 'Ganar tres campañas',
          steps: jsonEncode({
            'Usa estrategias de ataque y defensa': false,
            'Investiga tecnologías avanzadas': false,
            'Maneja varias bases simultáneamente': false,
          }),
          expectedResults: 'Mejorar tus habilidades',
          difficulty: 'Media',
          rating: 7.0,
          gameId: 3,
          imageUrl: 'assets/starcraft.png',
        ),
        Routine(
          id: 9,
          name: 'Difícil',
          description: 'Una rutina difícil para expertos',
          objective: 'Ganar todas las campañas sin perder unidades clave',
          steps: jsonEncode({
            'Usa tácticas avanzadas de microgestión': false,
            'Coordina ataques múltiples': false,
            'Adapta estrategias según el enemigo': false,
          }),
          expectedResults: 'Convertirte en un maestro del juego',
          difficulty: 'Difícil',
          rating: 8.0,
          gameId: 3,
          imageUrl: 'assets/starcraft.png',
        ),
      ],
    ),
    Game(
      id: 4,
      name: 'Pacman',
      description: 'Un juego clásico de laberintos',
      imageUrl: 'assets/pacman.png',
      genre: 'Arcade',
      year: 1980,
      developer: 'Namco',
      link: 'https://pacman.com/en/',
      rating: 8.5,
      routines: [
        Routine(
          id: 10,
          name: 'Fácil',
          description: 'Una rutina fácil para principiantes',
          objective: 'Completar el primer nivel',
          steps: jsonEncode({
            'Come todos los puntos': false,
            'Evita a los fantasmas': false,
            'Usa los power pellets estratégicamente': false,
          }),
          expectedResults: 'Aprender las mecánicas básicas',
          difficulty: 'Fácil',
          rating: 6.5,
          gameId: 4,
          imageUrl: 'assets/pacman.png',
        ),
        Routine(
          id: 11,
          name: 'Media',
          description: 'Una rutina de dificultad media',
          objective: 'Completar los primeros 3 niveles',
          steps: jsonEncode({
            'Memoriza los patrones de los fantasmas': false,
            'Usa los túneles de manera eficiente': false,
            'Maximiza el uso de los power pellets': false,
          }),
          expectedResults: 'Mejorar tus habilidades',
          difficulty: 'Media',
          rating: 7.5,
          gameId: 4,
          imageUrl: 'assets/pacman.png',
        ),
        Routine(
          id: 12,
          name: 'Difícil',
          description: 'Una rutina difícil para expertos',
          objective: 'Completar el juego sin perder vidas',
          steps: jsonEncode({
            'Predice los movimientos de los fantasmas': false,
            'Aprovecha al máximo los power pellets': false,
            'Juega a alta velocidad': false,
          }),
          expectedResults: 'Convertirte en un maestro del juego',
          difficulty: 'Difícil',
          rating: 8.5,
          gameId: 4,
          imageUrl: 'assets/pacman.png',
        ),
      ],
    ),
  ];
}
