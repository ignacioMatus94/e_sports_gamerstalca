import 'package:flutter/material.dart';
import '../models/juego.dart';
import '../models/perfil.dart';
import '../models/rutina.dart';
import '../services/database_service.dart';
import '../widgets/drawer_clase.dart';

class PantallaSeleccionarRutina extends StatefulWidget {
  final List<Juego> juegos;
  final List<Perfil> perfiles;
  final Map<int, Rutina> rutinasSeleccionadas;

  const PantallaSeleccionarRutina({
    super.key,
    required this.juegos,
    required this.perfiles,
    required this.rutinasSeleccionadas,
  });

  @override
  _PantallaSeleccionarRutinaState createState() => _PantallaSeleccionarRutinaState();
}

class _PantallaSeleccionarRutinaState extends State<PantallaSeleccionarRutina> {
  late Future<Map<int, Rutina?>> _rutinasSeleccionadas;

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
    final perfil = widget.perfiles.first;

    try {
      for (var juego in widget.juegos) {
        print('Cargando rutina para el juego: ${juego.nombre}'); // Verificación
        final rutinaMap = await DatabaseService().getRutinaSeleccionada(perfil.id, juego.id);
        if (rutinaMap != null) {
          print('Rutina encontrada: ${rutinaMap['nombre']}'); // Verificación
          rutinasSeleccionadas[juego.id] = Rutina.fromMap(rutinaMap);
        } else {
          print('No se encontró rutina para el juego: ${juego.nombre}'); // Verificación
          rutinasSeleccionadas[juego.id] = null;
        }
      }
    } catch (e) {
      debugPrint('Error loading rutinas: $e');
      throw Exception('Failed to load rutinas');
    }
    return rutinasSeleccionadas;
  }

  void _guardarRutinaSeleccionada(int juegoId, Rutina rutina) async {
    final perfil = widget.perfiles.first;
    try {
      print('Guardando rutina: ${rutina.nombre} para el juegoId: $juegoId'); // Verificación
      await DatabaseService().deleteRutinaForPerfil(perfil.id, juegoId);
      await DatabaseService().selectRutinaForPerfil(perfil.id, rutina.id, juegoId);
      setState(() {
        widget.rutinasSeleccionadas[juegoId] = rutina; // Actualizar el mapa con la nueva selección
      });
      _fetchRutinasSeleccionadas();
      if (mounted) {
        Navigator.pop(context, true);
      }
    } catch (e) {
      debugPrint('Error saving rutina: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al guardar la rutina.')),
        );
      }
    }
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
            if (snapshot.hasData) {
              print('Rutinas seleccionadas cargadas correctamente'); // Verificación
            }
            final rutinasSeleccionadas = snapshot.data!;
            return ListView.builder(
              itemCount: widget.juegos.length,
              itemBuilder: (context, index) {
                final juego = widget.juegos[index];
                final rutinaSeleccionada = rutinasSeleccionadas[juego.id];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ExpansionTile(
                    title: Text(juego.nombre),
                    children: juego.rutinas.map((rutina) {
                      return ListTile(
                        title: Text(rutina.nombre),
                        trailing: rutinaSeleccionada?.id == rutina.id
                            ? const Icon(Icons.check, color: Colors.green)
                            : null,
                        onTap: () {
                          _guardarRutinaSeleccionada(juego.id, rutina);
                        },
                      );
                    }).toList(),
                  ),
                );
              },
            );
          }
        },
      ),
      perfiles: widget.perfiles,
      juegos: widget.juegos,
    );
  }
}
