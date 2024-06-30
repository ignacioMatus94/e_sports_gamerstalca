import 'package:e_sports_gamerstalca/models/rutina.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/juego.dart';
import '../models/perfil.dart';
import '../widgets/drawer_clase.dart';

class PantallaDetallesJuegos extends StatelessWidget {
  final Juego juego;
  final List<Perfil> perfiles;
  final Map<int, Rutina> rutinasSeleccionadas;

  const PantallaDetallesJuegos({
    super.key,
    required this.juego,
    required this.perfiles,
    required this.rutinasSeleccionadas,
  });

  @override
  Widget build(BuildContext context) {
    const double imageSize = 100.0;

    return DrawerClase.buildScaffold(
      context: context,
      title: 'Detalles del Juego',
      body: ListView(
        children: [
          Center(
            child: Image.asset(
              juego.imagenUrl,
              width: imageSize,
              height: imageSize,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.category),
            title: Text('Género: ${juego.genero}'),
          ),
          ListTile(
            leading: const Icon(Icons.calendar_today),
            title: Text('Lanzamiento: ${juego.ano}'),
          ),
          ListTile(
            leading: const Icon(Icons.business),
            title: Text('Desarrollador: ${juego.desarrollador}'),
          ),
          ListTile(
            leading: const Icon(Icons.description),
            title: Text('Descripción: ${juego.descripcion}'),
          ),
          ListTile(
            leading: const Icon(Icons.link),
            title: const Text('Link:'),
            subtitle: Text(juego.link),
            onTap: () {
              _launchURL(juego.link);
            },
          ),
          ListTile(
            leading: const Icon(Icons.star),
            title: Text('Puntuación: ${juego.puntuacion}'),
          ),
          for (var rutina in juego.rutinas)
            ExpansionTile(
              leading: const Icon(Icons.fitness_center),
              title: Text(rutina.nombre),
              subtitle: Text('Dificultad: ${rutina.dificultad}'),
              children: [
                ListTile(
                  leading: const Icon(Icons.description),
                  title: Text('Descripción: ${rutina.descripcion}'),
                ),
                ListTile(
                  leading: const Icon(Icons.flag),
                  title: Text('Objetivo: ${rutina.objetivo}'),
                ),
                ListTile(
                  leading: const Icon(Icons.list),
                  title: Text('Pasos: ${rutina.pasos}'),
                ),
                ListTile(
                  leading: const Icon(Icons.check_circle),
                  title: Text('Resultados Esperados: ${rutina.resultadosEsperados}'),
                ),
              ],
            ),
        ],
      ),
      perfiles: perfiles,
      juegos: [],
    );
  }

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'No se pudo abrir el enlace $url';
    }
  }
}
