import 'package:flutter/material.dart';
import 'drawer_clase.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class PantallaConfiguracion extends StatefulWidget {
  const PantallaConfiguracion({super.key});

  @override
  PantallaConfiguracionState createState() {
    logger.i('Crear estado PantallaConfiguracion');
    return PantallaConfiguracionState();
  }
}

class PantallaConfiguracionState extends State<PantallaConfiguracion> {
  bool notificaciones = true;

  @override
  void initState() {
    super.initState();
    logger.i('initState PantallaConfiguracion');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    logger.i('didChangeDependencies PantallaConfiguracion');
  }

  @override
  void didUpdateWidget(PantallaConfiguracion oldWidget) {
    super.didUpdateWidget(oldWidget);
    logger.i('didUpdateWidget PantallaConfiguracion');
  }

  @override
  void deactivate() {
    logger.i('deactivate PantallaConfiguracion');
    super.deactivate();
  }

  @override
  void dispose() {
    logger.i('dispose PantallaConfiguracion');
    super.dispose();
  }

  @override
  void reassemble() {
    super.reassemble();
    logger.i('reassemble PantallaConfiguracion');
  }

  @override
  Widget build(BuildContext context) {
    logger.i('build PantallaConfiguracion');
    return DrawerClase.buildScaffold(
      context,
      'Configuración',
      Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade100, Colors.blue.shade300],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ajustes de Notificaciones',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    SwitchListTile(
                      title: const Text('Activar Notificaciones'),
                      value: notificaciones,
                      onChanged: (bool value) {
                        setState(() {
                          notificaciones = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
