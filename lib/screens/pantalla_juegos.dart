import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Importar el paquete url_launcher
import '../models/juego.dart';
import '../models/perfil.dart';
import '../widgets/drawer_clase.dart';
import '../constants/colors.dart'; 

class PantallaJuegos extends StatelessWidget {
  final List<Juego> juegos;
  final Perfil perfil;
  final List<Perfil> perfiles;

  const PantallaJuegos({
    super.key,
    required this.juegos,
    required this.perfil,
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
      print('Error al intentar abrir el enlace: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('No se pudo abrir el enlace: $url. $e'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
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
                title: Text(juego.nombre, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                subtitle: Text(juego.descripcion),
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.videogame_asset),
                    title: Text('Género: ${juego.genero}'),
                  ),
                  ListTile(
                    leading: Icon(Icons.date_range),
                    title: Text('Lanzamiento: ${juego.ano}'),
                  ),
                  ListTile(
                    leading: Icon(Icons.business),
                    title: Text('Desarrollador: ${juego.desarrollador}'),
                  ),
                  ListTile(
                    leading: Icon(Icons.link),
                    title: Text('Sitio Oficial'),
                    onTap: () => _launchURL(context, juego.link), // Llamar a la función para abrir el enlace
                  ),
                  ListTile(
                    leading: Icon(Icons.description),
                    title: Text('Descripción: ${juego.descripcion}'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      perfil: perfil,
      perfiles: perfiles,
      juegos: juegos,
    );
  }
}
