import 'package:e_sports_gamerstalca/configuracion_list_tile.dart';
import 'package:e_sports_gamerstalca/configuracion_switch_tile.dart';
import 'package:flutter/material.dart';
import '../models/perfil.dart';
import '../constants/colors.dart';
import '../widgets/drawer_clase.dart';

class PantallaConfiguracion extends StatefulWidget {
  final List<Perfil> perfiles;

  const PantallaConfiguracion({
    super.key, // Convertir 'key' a un super parámetro
    required this.perfiles,
  });

  @override
  PantallaConfiguracionState createState() => PantallaConfiguracionState(); // Hacer la clase pública
}

class PantallaConfiguracionState extends State<PantallaConfiguracion> {
  bool _notificationsEnabled = false;
  bool _darkModeEnabled = false;

  @override
  Widget build(BuildContext context) {

    return DrawerClase.buildScaffold(
      context: context,
      title: 'Configuración',
      body: Container(
        color: backgroundColor,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            ConfiguracionSwitchTile(
              title: 'Activar notificaciones',
              value: _notificationsEnabled,
              onChanged: (bool value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
              activeColor: appBarColor,
            ),
            ConfiguracionSwitchTile(
              title: 'Modo oscuro',
              value: _darkModeEnabled,
              onChanged: (bool value) {
                setState(() {
                  _darkModeEnabled = value;
                });
              },
              activeColor: appBarColor,
            ),
            ConfiguracionListTile(
              icon: Icons.language,
              title: 'Idioma',
              onTap: () {
                // Implementar la funcionalidad de cambio de idioma aquí
              },
            ),
            ConfiguracionListTile(
              icon: Icons.lock,
              title: 'Privacidad',
              onTap: () {
                // Implementar la funcionalidad de configuración de privacidad aquí
              },
            ),
            ConfiguracionListTile(
              icon: Icons.info,
              title: 'Acerca de',
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Colors.purple[100],
                      title: Row(
                        children: [
                          Icon(Icons.info, color: Colors.deepPurple[900]),
                          const SizedBox(width: 10), // Añadir const
                          Text('Acerca de', style: TextStyle(color: Colors.deepPurple[900])),
                        ],
                      ),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.person, color: Colors.deepPurple[900]),
                              const SizedBox(width: 10), // Añadir const
                              Expanded(
                                child: Text(
                                  'Encantado de conocerte, soy Ignacio Matus, el creador de esta aplicación, '
                                  'feliz de saber tu preferencia en nuestra aplicación y búsqueda en mejorar tu rendimiento en los videojuegos.',
                                  style: TextStyle(color: Colors.deepPurple[900]),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text('OK', style: TextStyle(color: Colors.deepPurple[900])),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      perfiles: widget.perfiles,
      juegos: const [],
    );
  }
}
