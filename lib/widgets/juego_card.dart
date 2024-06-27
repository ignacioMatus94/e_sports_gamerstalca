import 'package:flutter/material.dart';
import '../models/juego.dart';
import '../models/perfil.dart';
import '../screens/pantalla_detalles_juegos.dart';

class JuegoCard extends StatelessWidget {
  final Juego juego;
  final Perfil perfil;
  final List<Perfil> perfiles;

  const JuegoCard({
    super.key,
    required this.juego,
    required this.perfil,
    required this.perfiles,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: ListTile(
        leading: Image.asset(juego.imagenUrl, width: 50, height: 50),
        title: Text(juego.nombre),
        subtitle: Text('${juego.genero} • ${juego.ano}'),
        trailing: IconButton(
          icon: Icon(Icons.info),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PantallaDetallesJuegos(juego: juego, perfil: perfil, perfiles: perfiles),
              ),
            );
          },
        ),
      ),
    );
  }
}
