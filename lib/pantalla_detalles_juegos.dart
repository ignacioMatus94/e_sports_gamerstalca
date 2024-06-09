import 'package:flutter/material.dart';

class PantallaDetallesJuego extends StatelessWidget {
  final String nombreJuego;
  final String genero;
  final String descripcion;
  final String imagen;

  const PantallaDetallesJuego({
    super.key,
    required this.nombreJuego,
    required this.genero,
    required this.descripcion,
    required this.imagen,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(nombreJuego),
        backgroundColor: Theme.of(context).colorScheme.primary,
        
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.asset(imagen, height: 200)),
            const SizedBox(height: 20),
            Text(
              nombreJuego,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Género: $genero',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 10),
            Text(
              descripcion,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
