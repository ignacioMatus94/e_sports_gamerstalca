import 'package:flutter/material.dart';
import '../models/perfil.dart';
import '../models/juego.dart';
import '../models/rutina.dart';
import '../widgets/drawer_clase.dart';

class PantallaPerfil extends StatelessWidget {
  final List<Perfil> perfiles;
  final List<Juego> juegos;
  final Map<int, Rutina> rutinasSeleccionadas;

  const PantallaPerfil({
    super.key,
    required this.perfiles,
    required this.juegos,
    required this.rutinasSeleccionadas,
  });

  @override
  Widget build(BuildContext context) {
    final perfil = perfiles.first;

    return DrawerClase.buildScaffold(
      context: context,
      title: 'Perfil',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(perfil.avatarUrl),
            ),
            const SizedBox(height: 16),
            Text(
              'Nombre: ${perfil.nombre}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/avance', arguments: rutinasSeleccionadas);
              },
              child: const Text('Ver avances'),
            ),
            const SizedBox(height: 16),
            Text(
              'Rutinas Seleccionadas:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: juegos.length,
                itemBuilder: (context, index) {
                  final juego = juegos[index];
                  final rutina = rutinasSeleccionadas[juego.id];
                  if (rutina != null) {
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        title: Text(juego.nombre),
                        subtitle: Text('Rutina: ${rutina.nombre} - Nivel: ${rutina.dificultad}'),
                      ),
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),
            ),
          ],
        ),
      ),
      perfiles: perfiles,
      juegos: juegos,
    );
  }
}
