import 'package:flutter/material.dart';
import '../models/juego.dart';
import '../models/perfil.dart';
import '../widgets/drawer_clase.dart';

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

  @override
  Widget build(BuildContext context) {
    return DrawerClase.buildScaffold(
      context: context,
      title: 'E_SPORT_GAMERSTALCA',
      body: ListView.builder(
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
                  leading: Icon(Icons.description),
                  title: Text('Descripción: ${juego.descripcion}'),
                ),
              ],
            ),
          );
        },
      ),
      perfil: perfil,
      perfiles: perfiles,
      juegos: juegos,
    );
  }
}
