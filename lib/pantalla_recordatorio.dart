import 'package:flutter/material.dart';

class PantallaRecordatorios extends StatefulWidget {
  const PantallaRecordatorios({super.key});

  @override
  PantallaRecordatoriosState createState() => PantallaRecordatoriosState();
}

class PantallaRecordatoriosState extends State<PantallaRecordatorios> {
  final List<Map<String, dynamic>> recordatorios = [
    {
      'recordatorio': 'Entrena diariamente',
      'juegos': [
        {
          'nombre': 'Mario',
          'imagen': 'assets/mario.png',
          'cumplido': false,
          'progreso': [true, false, true, true, false, true, true],
          'puntaje': 80,
          'torneos': '01/07/2024',
        },
        {
          'nombre': 'Starcraft',
          'imagen': 'assets/start.png',
          'cumplido': false,
          'progreso': [true, true, false, false, true, true, false],
          'puntaje': 95,
          'torneos': '15/07/2024',
        },
        {
          'nombre': 'Rayman',
          'imagen': 'assets/rayman.png',
          'cumplido': false,
          'progreso': [true, false, true, true, true, false, true],
          'puntaje': 70,
          'torneos': '22/07/2024',
        },
      ],
    },
    {
      'recordatorio': 'Revisa tus estadísticas',
      'juegos': [
        {
          'nombre': 'Mario',
          'imagen': 'assets/mario.png',
          'puntaje': 80,
          'recomendacion': 'Sigue mejorando tu tiempo de reacción.',
        },
        {
          'nombre': 'Starcraft',
          'imagen': 'assets/start.png',
          'puntaje': 95,
          'recomendacion': 'Trabaja en tu gestión de recursos.',
        },
        {
          'nombre': 'Rayman',
          'imagen': 'assets/rayman.png',
          'puntaje': 70,
          'recomendacion': 'Enfócate en encontrar más secretos.',
        },
      ],
    },
    {
      'recordatorio': 'Participa en torneos',
      'juegos': [
        {
          'nombre': 'Mario',
          'imagen': 'assets/mario.png',
          'detallesTorneo': 'Ubicación: New York, Premios: \$5000',
          'torneos': '12/08/2024',
          'torneosPasados': [
            {'fecha': '01/06/2024', 'resultado': '1er lugar'},
            {'fecha': '15/05/2024', 'resultado': '2do lugar'},
          ],
        },
        {
          'nombre': 'Starcraft',
          'imagen': 'assets/start.png',
          'detallesTorneo': 'Ubicación: Los Angeles, Premios: \$10000',
          'torneos': '20/08/2024',
          'torneosPasados': [
            {'fecha': '15/06/2024', 'resultado': '3er lugar'},
            {'fecha': '20/05/2024', 'resultado': '1er lugar'},
          ],
        },
        {
          'nombre': 'Rayman',
          'imagen': 'assets/rayman.png',
          'detallesTorneo': 'Ubicación: Tokyo, Premios: \$8000',
          'torneos': '28/08/2024',
          'torneosPasados': [
            {'fecha': '22/06/2024', 'resultado': '4to lugar'},
            {'fecha': '18/05/2024', 'resultado': '2do lugar'},
          ],
        },
      ],
    },
  ];

  void _toggleCumplido(Map<String, dynamic> juego) {
    setState(() {
      juego['cumplido'] = !juego['cumplido'];
    });
  }

  void _mostrarDetalles(BuildContext context, Map<String, dynamic> juego, String tipoRecordatorio) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Widget content;

        switch (tipoRecordatorio) {
          case 'Entrena diariamente':
            content = Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: Icon(
                    juego['cumplido'] ? Icons.check_circle : Icons.cancel,
                    color: juego['cumplido'] ? Colors.green : Colors.red,
                  ),
                  title: const Text('Entrenamiento', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Progreso semanal:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Row(
                  children: juego['progreso'].map<Widget>((dia) {
                    return Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Icon(
                        dia ? Icons.check_circle : Icons.cancel,
                        color: dia ? Colors.green : Colors.red,
                        size: 20,
                      ),
                    );
                  }).toList(),
                ),
              ],
            );
            break;
          case 'Revisa tus estadísticas':
            content = Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: const Icon(Icons.bar_chart),
                  title: Text(
                    'Puntaje: ${juego['puntaje']}',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Recomendación:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    juego['recomendacion'] ?? 'N/A',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            );
            break;
          case 'Participa en torneos':
            content = Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: const Icon(Icons.calendar_today),
                  title: Text(
                    'Próximo torneo: ${juego['torneos'] ?? 'Fecha no disponible'}',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Detalles del próximo torneo:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.location_on),
                    title: Text(
                      juego['detallesTorneo'] ?? 'Detalles no disponibles',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Torneos pasados:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Column(
                  children: (juego['torneosPasados'] as List<Map<String, String>>).map((torneo) {
                    return ListTile(
                      title: Text(
                        torneo['fecha']!,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        torneo['resultado']!,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    );
                  }).toList(),
                ),
              ],
            );
            break;
          default:
            content = const SizedBox.shrink();
        }

        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: Text(
            juego['nombre']!,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          content: content,
          actions: [
            TextButton(
              child: const Text(
                'Cerrar',
                style: TextStyle(color: Colors.blue),
              ),
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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade100, Colors.blue.shade300],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: recordatorios.length,
          itemBuilder: (context, index) {
            final recordatorio = recordatorios[index];
            return Card(
              color: Colors.white,
              shadowColor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recordatorio['recordatorio'],
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Column(
                      children: (recordatorio['juegos'] as List<Map<String, dynamic>>)
                          .map((juego) => Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5.0),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.asset(juego['imagen']!, width: 50, height: 50, fit: BoxFit.cover),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        juego['nombre']!,
                                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    if (recordatorio['recordatorio'] == 'Entrena diariamente')
                                      IconButton(
                                        icon: Icon(
                                          juego['cumplido'] ? Icons.check_circle : Icons.check_circle_outline,
                                          color: juego['cumplido'] ? Colors.green : Colors.grey,
                                        ),
                                        onPressed: () {
                                          _toggleCumplido(juego);
                                        },
                                      ),
                                    IconButton(
                                      icon: const Icon(Icons.info, color: Colors.blue),
                                      onPressed: () {
                                        _mostrarDetalles(context, juego, recordatorio['recordatorio']);
                                      },
                                    ),
                                  ],
                                ),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
