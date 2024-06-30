import 'package:e_sports_gamerstalca/models/rutina.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/juego.dart';
import '../models/perfil.dart';
import '../widgets/drawer_clase.dart';
import '../constants/colors.dart';

class PantallaJuegos extends StatelessWidget {
  final List<Juego> juegos;
  final List<Perfil> perfiles;

  const PantallaJuegos({
    super.key,
    required this.juegos,
    required this.perfiles,
  });

  Future<void> _launchURL(BuildContext context, String url) async {
    final Uri uri = Uri.parse(url);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw 'No se pudo abrir el enlace $url';
      }
    } catch (e) {
      debugPrint('Error al intentar abrir el enlace: $e');
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: Text('No se pudo abrir el enlace: $url. $e'),
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return DrawerClase.buildScaffold(
      context: context,
      title: 'E_SPORT_GAMERSTALCA',
      body: Container(
        color: backgroundColor,
        child: ListView.builder(
          itemCount: juegos.length,
          itemBuilder: (context, index) {
            final juego = juegos[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ExpansionTile(
                leading: Image.asset(juego.imagenUrl, width: 50, height: 50),
                title: Text(juego.nombre, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                subtitle: Text(juego.descripcion),
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.videogame_asset),
                    title: Text('Género: ${juego.genero}'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.date_range),
                    title: Text('Lanzamiento: ${juego.ano}'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.business),
                    title: Text('Desarrollador: ${juego.desarrollador}'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.link),
                    title: const Text('Sitio Oficial'),
                    onTap: () => _launchURL(context, juego.link),
                  ),
                  ListTile(
                    leading: const Icon(Icons.description),
                    title: Text('Descripción: ${juego.descripcion}'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      perfiles: perfiles,
      juegos: juegos,
    );
  }
}
