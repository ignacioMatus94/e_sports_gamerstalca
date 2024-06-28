import 'package:flutter/material.dart';
import '../models/rutina.dart';
import '../models/avance.dart';
import '../models/perfil.dart';
import '../models/juego.dart';
import '../widgets/drawer_clase.dart';
import '../services/database_service.dart';

class PantallaAvance extends StatefulWidget {
  final Rutina rutina;
  final Perfil perfil;
  final List<Perfil> perfiles;
  final List<Juego> juegos;

  const PantallaAvance({
    super.key,
    required this.rutina,
    required this.perfil,
    required this.perfiles,
    required this.juegos,
  });

  @override
  _PantallaAvanceState createState() => _PantallaAvanceState();
}

class _PantallaAvanceState extends State<PantallaAvance> {
  late Future<List<Avance>> _avancesFuturos;

  @override
  void initState() {
    super.initState();
    _avancesFuturos = _fetchAvances();
  }

  Future<List<Avance>> _fetchAvances() async {
    return await DatabaseService().getAvances(widget.perfil.id!, widget.rutina.id!);
  }

  Future<void> _addAvance(int progreso) async {
    final nuevoAvance = Avance(
      id: null,
      perfilId: widget.perfil.id!,
      rutinaId: widget.rutina.id!,
      fecha: DateTime.now(),
      progreso: progreso,
    );

    await DatabaseService().insertAvance(nuevoAvance);

    setState(() {
      _avancesFuturos = _fetchAvances();
    });
  }

  @override
  Widget build(BuildContext context) {
    final int totalPasos = _getTotalPasos(widget.rutina.pasos);
    return DrawerClase.buildScaffold(
      context: context,
      title: 'Detalles del videojuego ${widget.rutina.nombre}',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Rutina: ${widget.rutina.nombre}', style: TextStyle(fontSize: 20)),
            Text('Objetivo: ${widget.rutina.objetivo}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _showAddAvanceDialog(context);
              },
              child: Text('Registrar Avance'),
            ),
            const SizedBox(height: 20),
            Text('Historial de Avances', style: TextStyle(fontSize: 18)),
            Expanded(
              child: FutureBuilder<List<Avance>>(
                future: _avancesFuturos,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error al cargar los avances'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No hay avances registrados'));
                  } else {
                    final avances = snapshot.data!;
                    final pasosRealizados = avances.fold(0, (sum, avance) => sum + avance.progreso);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Progreso: $pasosRealizados / $totalPasos'),
                        Expanded(
                          child: ListView.builder(
                            itemCount: avances.length,
                            itemBuilder: (context, index) {
                              final avance = avances[index];
                              return ListTile(
                                title: Text('Fecha: ${avance.fecha.toLocal()}'),
                                subtitle: Text('Progreso: ${avance.progreso}'),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      perfil: widget.perfil,
      perfiles: widget.perfiles,
      juegos: widget.juegos,
    );
  }

  void _showAddAvanceDialog(BuildContext context) {
    final TextEditingController progresoController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Registrar Avance'),
          content: TextField(
            controller: progresoController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Progreso'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Registrar'),
              onPressed: () {
                final int progreso = int.parse(progresoController.text);
                _addAvance(progreso);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  int _getTotalPasos(String pasos) {
    try {
      return int.parse(pasos);
    } catch (e) {
      return 1; // Valor por defecto si no es numérico
    }
  }
}
