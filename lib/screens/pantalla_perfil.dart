import 'package:flutter/material.dart';
import '../models/perfil.dart';
import '../models/juego.dart';
import '../models/rutina.dart';
import '../services/database_service.dart';
import '../widgets/drawer_clase.dart';
import '../constants/colors.dart';

class PantallaPerfil extends StatefulWidget {
  final Perfil perfil;
  final List<Perfil> perfiles;
  final List<Juego> juegos;

  const PantallaPerfil({
    super.key,
    required this.perfil,
    required this.perfiles,
    required this.juegos,
  });

  @override
  PantallaPerfilState createState() => PantallaPerfilState();
}

class PantallaPerfilState extends State<PantallaPerfil> {
  late Future<Map<int, Rutina?>> _rutinasSeleccionadas;

  @override
  void initState() {
    super.initState();
    _rutinasSeleccionadas = _fetchRutinasSeleccionadas();
  }

  Future<Map<int, Rutina?>> _fetchRutinasSeleccionadas() async {
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

  void _mostrarRutinaSeleccionada(BuildContext context, String juegoNombre, Rutina rutina) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.purple[100],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          title: Text('Detalles de:  $juegoNombre', style: TextStyle(color: Colors.deepPurple[900])),
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
      title: 'Perfil',
      body: Container(
        color: backgroundColor,
        child: FutureBuilder<Map<int, Rutina?>>(
          future: _rutinasSeleccionadas,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error al cargar rutinas.'));
            } else {
              final rutinasSeleccionadas = snapshot.data!;
              return _buildPerfilContent(context, rutinasSeleccionadas);
            }
          },
        ),
      ),
      perfil: widget.perfil,
      perfiles: widget.perfiles,
      juegos: widget.juegos,
    );
  }

  Widget _buildPerfilContent(BuildContext context, Map<int, Rutina?> rutinasSeleccionadas) {
    return Column(
      children: [
        Container(
          color: Colors.deepPurple[100],
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: CircleAvatar(
              backgroundImage: AssetImage(widget.perfil.avatarUrl),
              radius: 40,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: _buildProgresoJuegos(context, rutinasSeleccionadas),
        ),
      ],
    );
  }

  Widget _buildProgresoJuegos(BuildContext context, Map<int, Rutina?> rutinasSeleccionadas) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Progreso de Juegos',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ...widget.juegos.map((juego) {
            final rutinaSeleccionada = rutinasSeleccionadas[juego.id];
            return _buildJuegoCard(context, juego, rutinaSeleccionada);
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildJuegoCard(BuildContext context, Juego juego, Rutina? rutinaSeleccionada) {
    return Card(
      color: Colors.deepPurple[200],
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        tileColor: Colors.purple[100],
        leading: Image.asset(juego.imagenUrl, width: 50, height: 50),
        title: Text(juego.nombre, style: TextStyle(color: Colors.deepPurple[900])),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cambiar el texto aquí para "Puntuación máxima del juego: 10"
            Text('Puntuación máxima del juego: 10', style: TextStyle(color: Colors.deepPurple[700])),
            rutinaSeleccionada != null
                ? Text('Rutina seleccionada: ${rutinaSeleccionada.nombre} (Puntuación: ${rutinaSeleccionada.puntuacion})', style: TextStyle(color: Colors.deepPurple[700]))
                : const Text('Sin rutinas seleccionadas'),
          ],
        ),
        trailing: Icon(
          rutinaSeleccionada != null ? Icons.check_circle : Icons.radio_button_unchecked,
          color: rutinaSeleccionada != null ? Theme.of(context).primaryColor : Colors.grey,
        ),
        onTap: () {
          if (rutinaSeleccionada != null) {
            _mostrarRutinaSeleccionada(context, juego.nombre, rutinaSeleccionada);
          }
        },
      ),
    );
  }
}
