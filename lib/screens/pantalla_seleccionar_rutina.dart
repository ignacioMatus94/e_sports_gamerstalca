import 'package:flutter/material.dart';
import '../models/juego.dart';
import '../models/perfil.dart';
import '../models/rutina.dart';
import '../services/database_service.dart';
import '../widgets/drawer_clase.dart';

class PantallaSeleccionarRutina extends StatefulWidget {
  final List<Juego> juegos;
  final Perfil perfil;
  final List<Perfil> perfiles;

  const PantallaSeleccionarRutina({
    super.key,
    required this.juegos,
    required this.perfil,
    required this.perfiles,
  });

  @override
  _PantallaSeleccionarRutinaState createState() => _PantallaSeleccionarRutinaState();
}

class _PantallaSeleccionarRutinaState extends State<PantallaSeleccionarRutina> {
  late Future<Map<int, Rutina?>> _rutinasSeleccionadas;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchRutinasSeleccionadas();
  }

  Future<void> _fetchRutinasSeleccionadas() async {
    setState(() {
      _rutinasSeleccionadas = _loadRutinasSeleccionadas();
    });
  }

  Future<Map<int, Rutina?>> _loadRutinasSeleccionadas() async {
    final Map<int, Rutina?> rutinasSeleccionadas = {};
    for (var juego in widget.juegos) {
      final rutinaMap = await DatabaseService().getRutinaSeleccionada(widget.perfil.id!, juego.id);
      if (rutinaMap != null) {
        rutinasSeleccionadas[juego.id] = Rutina.fromMap(rutinaMap);
      } else {
        rutinasSeleccionadas[juego.id] = null;
      }
    }
    return rutinasSeleccionadas;
  }

  void _guardarRutinaSeleccionada(int juegoId, Rutina rutina) async {
    await DatabaseService().deleteRutinaForPerfil(widget.perfil.id!, juegoId);
    await DatabaseService().selectRutinaForPerfil(widget.perfil.id!, rutina.id!, juegoId);
    _fetchRutinasSeleccionadas();
  }

  void _eliminarRutinasGuardadas() async {
    await DatabaseService().deleteRutinasForPerfil(widget.perfil.id!);
    _fetchRutinasSeleccionadas();
  }

  Future<void> _reiniciarBaseDeDatos(BuildContext context) async {
    await DatabaseService().deleteDatabaseFile();
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
        link: 'https://mario.nintendo.com/es/',
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
            puntuacion: 7.5,
          ),
          Rutina(
            id: 2,
            nombre: 'Media',
            descripcion: 'Una rutina de dificultad media',
            objetivo: 'Completar los primeros 3 mundos',
            pasos: 'Sigue las estrategias avanzadas',
            resultadosEsperados: 'Mejorar tus habilidades',
            dificultad: 'Media',
            puntuacion: 8.5,
          ),
          Rutina(
            id: 3,
            nombre: 'Difícil',
            descripcion: 'Una rutina difícil para expertos',
            objetivo: 'Completar el juego sin morir',
            pasos: 'Sigue las estrategias de los expertos',
            resultadosEsperados: 'Convertirte en un maestro del juego',
            dificultad: 'Difícil',
            puntuacion: 9.5,
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
        link: 'https://www.ubisoft.com/es-es/game/rayman/origins',
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
            puntuacion: 7.0,
          ),
          Rutina(
            id: 5,
            nombre: 'Media',
            descripcion: 'Una rutina de dificultad media',
            objetivo: 'Completar los primeros 3 mundos',
            pasos: 'Sigue las estrategias avanzadas',
            resultadosEsperados: 'Mejorar tus habilidades',
            dificultad: 'Media',
            puntuacion: 8.0,
          ),
          Rutina(
            id: 6,
            nombre: 'Difícil',
            descripcion: 'Una rutina difícil para expertos',
            objetivo: 'Completar el juego sin morir',
            pasos: 'Sigue las estrategias de los expertos',
            resultadosEsperados: 'Convertirte en un maestro del juego',
            dificultad: 'Difícil',
            puntuacion: 9.0,
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
        link: 'https://starcraft2.blizzard.com',
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
            puntuacion: 7.5,
          ),
          Rutina(
            id: 8,
            nombre: 'Media',
            descripcion: 'Una rutina de dificultad media',
            objetivo: 'Ganar tres campañas',
            pasos: 'Usa las estrategias avanzadas',
            resultadosEsperados: 'Mejorar tus habilidades',
            dificultad: 'Media',
            puntuacion: 8.5,
          ),
          Rutina(
            id: 9,
            nombre: 'Difícil',
            descripcion: 'Una rutina difícil para expertos',
            objetivo: 'Ganar todas las campañas sin perder unidades clave',
            pasos: 'Sigue las estrategias de los expertos',
            resultadosEsperados: 'Convertirte en un maestro del juego',
            dificultad: 'Difícil',
            puntuacion: 9.5,
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
        link: 'https://pacman.com/en/',
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
            puntuacion: 6.5,
          ),
          Rutina(
            id: 11,
            nombre: 'Media',
            descripcion: 'Una rutina de dificultad media',
            objetivo: 'Completar los primeros 3 niveles',
            pasos: 'Sigue las estrategias avanzadas',
            resultadosEsperados: 'Mejorar tus habilidades',
            dificultad: 'Media',
            puntuacion: 7.5,
          ),
          Rutina(
            id: 12,
            nombre: 'Difícil',
            descripcion: 'Una rutina difícil para expertos',
            objetivo: 'Completar el juego sin perder vidas',
            pasos: 'Sigue las estrategias de los expertos',
            resultadosEsperados: 'Convertirte en un maestro del juego',
            dificultad: 'Difícil',
            puntuacion: 8.5,
          ),
        ],
      ),
    ];

    await DatabaseService().insertarRutinasIniciales(juegos);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Base de datos reiniciada con rutinas iniciales.')),
    );

    setState(() {
      _rutinasSeleccionadas = _loadRutinasSeleccionadas();
    });
  }

  void _mostrarDetallesJuego(BuildContext context, String juegoNombre, Rutina rutina) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.purple[100],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          title: Text('Detalles del videojuego $juegoNombre', style: TextStyle(color: Colors.deepPurple[900])),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.fitness_center, color: Colors.deepPurple[900]),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text('Nombre: ${rutina.nombre}', style: TextStyle(color: Colors.deepPurple[900])),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.description, color: Colors.deepPurple[900]),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text('Descripción: ${rutina.descripcion}', style: TextStyle(color: Colors.deepPurple[900])),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.flag, color: Colors.deepPurple[900]),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text('Objetivo: ${rutina.objetivo}', style: TextStyle(color: Colors.deepPurple[900])),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.list, color: Colors.deepPurple[900]),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text('Pasos: ${rutina.pasos}', style: TextStyle(color: Colors.deepPurple[900])),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.deepPurple[900]),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text('Resultados esperados: ${rutina.resultadosEsperados}', style: TextStyle(color: Colors.deepPurple[900])),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.verified, color: Colors.deepPurple[900]),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text('Dificultad: ${rutina.dificultad}', style: TextStyle(color: Colors.deepPurple[900])),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.deepPurple[900]),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text('Puntuación: ${rutina.puntuacion}', style: TextStyle(color: Colors.deepPurple[900])),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK', style: TextStyle(color: Colors.deepPurple)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DrawerClase.buildScaffold(
      context: context,
      title: 'Seleccionar Rutina',
      body: FutureBuilder<Map<int, Rutina?>>(
        future: _rutinasSeleccionadas,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar rutinas.'));
          } else {
            final rutinasSeleccionadas = snapshot.data!;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: widget.juegos.length,
                    itemBuilder: (context, index) {
                      final juego = widget.juegos[index];
                      final rutinaSeleccionada = rutinasSeleccionadas[juego.id];
                      return Card(
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(juego.nombre, style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.purple)),
                              const SizedBox(height: 10),
                              Text('Puntuación máxima del juego: 10', style: TextStyle(color: Colors.purple)),
                              const SizedBox(height: 10),
                              Column(
                                children: juego.rutinas.map((rutina) {
                                  return RadioListTile<Rutina>(
                                    title: Text('${rutina.nombre} (Puntuación: ${rutina.puntuacion})'),
                                    subtitle: Text(rutina.descripcion),
                                    value: rutina,
                                    groupValue: rutinaSeleccionada,
                                    onChanged: (Rutina? value) {
                                      if (value != null) {
                                        _guardarRutinaSeleccionada(juego.id, value);
                                      }
                                    },
                                  );
                                }).toList(),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                rutinaSeleccionada != null ? 'Rutina seleccionada: ${rutinaSeleccionada.nombre}' : 'No hay rutina seleccionada',
                                style: TextStyle(color: Colors.purple),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _reiniciarBaseDeDatos(context),
                  child: const Text('Eliminar base de datos y reiniciar con rutinas iniciales'),
                ),
                const SizedBox(height: 20),
              ],
            );
          }
        },
      ),
      perfil: widget.perfil,
      perfiles: widget.perfiles,
      juegos: widget.juegos,
    );
  }
}
