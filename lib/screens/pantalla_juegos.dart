import 'package:flutter/material.dart';
import '../models/juego.dart';
import '../models/perfil.dart';
import '../widgets/drawer_clase.dart';

class PantallaJuegos extends StatelessWidget {
  final List<Juego> juegos;
  final Perfil perfil;
  final List<Perfil> perfiles;

  PantallaJuegos({required this.juegos, required this.perfil, required this.perfiles});

  @override
  Widget build(BuildContext context) {
    return DrawerClase.buildScaffold(
      context: context,
      title: 'Listado de Juegos',
      body: ListView.builder(
        itemCount: juegos.length,
        itemBuilder: (context, index) {
          final juego = juegos[index];
          return Card(
            margin: EdgeInsets.all(10.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 5,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    juego.nombre,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Image.asset(juego.imagenUrl, height: 150),
                  ),
                  SizedBox(height: 10),
                  _buildSectionTitle(context, Icons.fitness_center, 'Rutinas'),
                  ...juego.rutinas.map((rutina) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: Text('• ${rutina.nombre}', style: TextStyle(fontSize: 16)),
                  )).toList(),
                  SizedBox(height: 10),
                  _buildSectionTitle(context, Icons.directions_run, 'Pasos a seguir'),
                  ...juego.rutinas.map((rutina) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: Text('• ${rutina.pasos}', style: TextStyle(fontSize: 16)),
                  )).toList(),
                  SizedBox(height: 10),
                  _buildSectionTitle(context, Icons.assessment, 'Resultados esperados'),
                  ...juego.rutinas.map((rutina) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: Text('• ${rutina.resultadosEsperados}', style: TextStyle(fontSize: 16)),
                  )).toList(),
                ],
              ),
            ),
          );
        },
      ),
      perfil: perfil,
      perfiles: perfiles,
      juegos: juegos,
    );
  }

  Widget _buildSectionTitle(BuildContext context, IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, color: Theme.of(context).primaryColor),
        SizedBox(width: 5),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}
