import 'package:flutter/material.dart';
import '../models/historial.dart';
import '../services/database_service.dart';
import '../models/rutina.dart';
import '../models/perfil.dart';
import '../models/juego.dart';
import '../widgets/drawer_clase.dart';

class PantallaHistorialAvances extends StatelessWidget {
  final Rutina rutina;
  final Perfil perfil;
  final List<Juego> juegos;

  const PantallaHistorialAvances({super.key, required this.rutina, required this.perfil, required this.juegos});

  @override
  Widget build(BuildContext context) {
    return DrawerClase.buildScaffold(
      context: context,
      title: 'Historial de Avances',
      body: FutureBuilder<List<Historial>>(
        future: DatabaseService().getHistoriales(rutina.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay historial de avances.'));
          } else {
            final historiales = snapshot.data!;
            return ListView.builder(
              itemCount: historiales.length,
              itemBuilder: (context, index) {
                final historial = historiales[index];
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: ListTile(
                    title: Text(historial.descripcion),
                    subtitle: Text(historial.fecha.toString()),
                  ),
                );
              },
            );
          }
        },
      ),
      perfil: perfil,
      perfiles: [], // Proporcionar los perfiles necesarios si se usan en DrawerClase
      juegos: juegos,
    );
  }
}
