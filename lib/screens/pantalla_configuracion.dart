import 'package:flutter/material.dart';
import '../models/perfil.dart';
import '../constants/colors.dart'; // Importar el archivo de colores

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

  void _mostrarAcercaDe(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.purple[100],
          title: Row(
            children: [
              Icon(Icons.info, color: Colors.deepPurple[900]),
              SizedBox(width: 8),
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
                  SizedBox(width: 8),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.deepPurple[700], fontSize: 16),
                        children: <TextSpan>[
                          TextSpan(text: 'Encantado de conocerte, soy '),
                          TextSpan(
                            text: 'Ignacio Matus',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple[900]),
                          ),
                          TextSpan(text: ', el creador de esta aplicación.'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.favorite, color: Colors.deepPurple[900]),
                  SizedBox(width: 8),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.deepPurple[700], fontSize: 16),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Feliz de saber tu preferencia en nuestra aplicación y búsqueda en mejorar tu rendimiento en los videojuegos.',
                            style: TextStyle(color: Colors.deepPurple[700]),
                          ),
                        ],
                      ),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configuración', style: TextStyle(color: titleTextColor)), // Usar el color definido
        backgroundColor: appBarColor, // Usar el color definido
      ),
      body: Container(
        color: Colors.purple[50], // Fondo acorde a la paleta de colores
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
                _mostrarAcercaDe(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
