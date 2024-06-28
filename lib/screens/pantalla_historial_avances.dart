import 'package:flutter/material.dart';
import '../models/juego.dart';
import '../models/perfil.dart';
import '../models/rutina.dart';
import '../services/database_service.dart';
import '../constants/colors.dart';
import '../widgets/drawer_clase.dart'; 

class PantallaHistorialAvances extends StatelessWidget {
  final Rutina rutina;
  final Perfil perfil;
  final List<Juego> juegos;

  const PantallaHistorialAvances({
    super.key,
    required this.rutina,
    required this.perfil,
    required this.juegos,
  });

  @override
  Widget build(BuildContext context) {
    return DrawerClase.buildScaffold(
      context: context,
      title: 'Historial de Avances',
      body: Container(
        color: backgroundColor, // Usar el color de fondo definido
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: DatabaseService().getHistoriales(rutina.id!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No hay historial de avances.'));
            } else {
              final historiales = snapshot.data!;
              return ListView.builder(
                itemCount: historiales.length,
                itemBuilder: (context, index) {
                  final historial = historiales[index];
                  return ListTile(
                    title: Text(historial['fecha']),
                    subtitle: Text('Progreso: ${historial['progreso']}%'),
                  );
                },
              );
            }
          },
        ),
      ),
      perfil: perfil,
      perfiles: [perfil],
      juegos: juegos,
    );
  }
}
