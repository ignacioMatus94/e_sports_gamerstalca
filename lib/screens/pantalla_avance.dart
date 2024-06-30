import 'package:flutter/material.dart';
import 'package:e_sports_gamerstalca/avance_listview.dart';
import '../models/rutina.dart';
import '../models/avance.dart';
import '../models/perfil.dart';
import '../models/juego.dart';
import '../widgets/drawer_clase.dart';
import '../services/database_service.dart';

class PantallaAvance extends StatefulWidget {
  final Map<int, Rutina> rutinasSeleccionadas;
  final List<Perfil> perfiles;
  final List<Juego> juegos;

  const PantallaAvance({
    super.key,
    required this.rutinasSeleccionadas,
    required this.perfiles,
    required this.juegos,
  });

  @override
  PantallaAvanceState createState() => PantallaAvanceState();
}

class PantallaAvanceState extends State<PantallaAvance> {
  late Future<Map<int, List<Avance>>> _avancesFuturos;

  @override
  void initState() {
    super.initState();
    _avancesFuturos = _fetchAvances();
  }

  Future<Map<int, List<Avance>>> _fetchAvances() async {
    Map<int, List<Avance>> avancesMap = {};
    for (Rutina rutina in widget.rutinasSeleccionadas.values) {
      avancesMap[rutina.id] = await DatabaseService().getAvances(widget.perfiles.first.id, rutina.id);
    }
    return avancesMap;
  }

  @override
  Widget build(BuildContext context) {
    final perfil = widget.perfiles.first;

    return DrawerClase.buildScaffold(
      context: context,
      title: 'Detalles de los avances',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Perfil: ${perfil.nombre}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<Map<int, List<Avance>>>(
                future: _avancesFuturos,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Error al cargar los avances'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No hay avances registrados'));
                  } else {
                    final avancesMap = snapshot.data!;
                    return AvanceListView(
                      juegos: widget.juegos,
                      avancesMap: avancesMap,
                      rutinasSeleccionadas: widget.rutinasSeleccionadas.values.toList(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      perfiles: widget.perfiles,
      juegos: widget.juegos,
    );
  }
}
