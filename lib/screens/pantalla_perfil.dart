import 'package:flutter/material.dart';
import '../models/juego.dart';
import '../models/perfil.dart';
import '../models/rutina.dart';
import '../services/database_service.dart';
import '../widgets/drawer_clase.dart';

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
      rutinasSeleccionadas[juego.id] =
          await DatabaseService().getRutinaSeleccionada(widget.perfil.id, juego.id);
      print('Cargada rutina seleccionada para juego ${juego.id}: ${rutinasSeleccionadas[juego.id]?.nombre}');
    }
    return rutinasSeleccionadas;
  }

  void _mostrarRutinaSeleccionada(BuildContext context, String juegoNombre, Rutina rutina) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Rutina seleccionada para $juegoNombre'),
          content: Text('Rutina: ${rutina.nombre}'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
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
      body: FutureBuilder<Map<int, Rutina?>>(
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
      perfil: widget.perfil,
      perfiles: widget.perfiles,
      juegos: widget.juegos,
    );
  }

  Widget _buildPerfilContent(BuildContext context, Map<int, Rutina?> rutinasSeleccionadas) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(widget.perfil.avatarUrl),
                  radius: 40,
                ),
                const SizedBox(width: 16),
                Text(
                  'Perfil de ${widget.perfil.nombreUsuario}',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildProgresoJuegos(context, rutinasSeleccionadas),
          ],
        ),
      ),
    );
  }

  Widget _buildProgresoJuegos(BuildContext context, Map<int, Rutina?> rutinasSeleccionadas) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Progreso de Juegos',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 10),
        ...widget.juegos.map((juego) {
          final rutinaSeleccionada = rutinasSeleccionadas[juego.id];
          return _buildJuegoCard(context, juego, rutinaSeleccionada);
        }).toList(),
      ],
    );
  }

  Widget _buildJuegoCard(BuildContext context, Juego juego, Rutina? rutinaSeleccionada) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Image.asset(juego.imagenUrl, width: 50, height: 50),
        title: Text(juego.nombre),
        subtitle: rutinaSeleccionada != null
            ? Text('Rutina seleccionada: ${rutinaSeleccionada.nombre}')
            : const Text('Sin rutinas seleccionadas'),
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
