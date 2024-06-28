import 'package:flutter/material.dart';
import '../models/perfil.dart';
import '../constants/colors.dart';
import '../widgets/drawer_clase.dart'; 

class PantallaConfiguracion extends StatefulWidget {
  final Perfil perfil;

  const PantallaConfiguracion({
    super.key,
    required this.perfil,
  });

  @override
  _PantallaConfiguracionState createState() => _PantallaConfiguracionState();
}

class _PantallaConfiguracionState extends State<PantallaConfiguracion> {
  bool _notificationsEnabled = false;
  bool _darkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    return DrawerClase.buildScaffold(
      context: context,
      title: 'Configuración',
      body: Container(
        color: backgroundColor, // Fondo acorde a la paleta de colores
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            SwitchListTile(
              activeColor: appBarColor,
              title: Text('Activar notificaciones', style: TextStyle(color: Colors.deepPurple[900])),
              value: _notificationsEnabled,
              onChanged: (bool value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
            ),
            SwitchListTile(
              activeColor: appBarColor,
              title: Text('Modo oscuro', style: TextStyle(color: Colors.deepPurple[900])),
              value: _darkModeEnabled,
              onChanged: (bool value) {
                setState(() {
                  _darkModeEnabled = value;
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.language, color: Colors.deepPurple[900]),
              title: Text('Idioma', style: TextStyle(color: Colors.deepPurple[900])),
              onTap: () {
                // Implementar la funcionalidad de cambio de idioma aquí
              },
            ),
            ListTile(
              leading: Icon(Icons.lock, color: Colors.deepPurple[900]),
              title: Text('Privacidad', style: TextStyle(color: Colors.deepPurple[900])),
              onTap: () {
                // Implementar la funcionalidad de configuración de privacidad aquí
              },
            ),
            ListTile(
              leading: Icon(Icons.info, color: Colors.deepPurple[900]),
              title: Text('Acerca de', style: TextStyle(color: Colors.deepPurple[900])),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Colors.purple[100],
                      title: Row(
                        children: [
                          Icon(Icons.info, color: Colors.deepPurple[900]),
                          SizedBox(width: 10),
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
                              SizedBox(width: 10),
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
      perfil: widget.perfil,
      perfiles: const [], 
      juegos: const [], 
    );
  }
}
