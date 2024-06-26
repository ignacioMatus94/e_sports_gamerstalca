import 'package:flutter/material.dart';
import '../models/juego.dart';
import '../models/perfil.dart';
import '../models/rutina.dart';
import '../services/database_service.dart';
import '../widgets/drawer_clase.dart';

class PantallaSeleccionarRutina extends StatefulWidget {
  final List<Juego> juegos;
  final Perfil perfil;
  final List<Perfil> perfiles;

  PantallaSeleccionarRutina({required this.juegos, required this.perfil, required this.perfiles});

  @override
  _PantallaSeleccionarRutinaState createState() => _PantallaSeleccionarRutinaState();
}

class _PantallaSeleccionarRutinaState extends State<PantallaSeleccionarRutina> {
  final Map<int, Rutina?> _rutinaSeleccionada = {};

  @override
  void initState() {
    super.initState();
    _loadRutinasSeleccionadas();
  }

  Future<void> _loadRutinasSeleccionadas() async {
    for (var juego in widget.juegos) {
      _rutinaSeleccionada[juego.id] = await DatabaseService().getRutinaSeleccionada(widget.perfil.id, juego.id);
      print('Cargada rutina seleccionada para juego ${juego.id}: ${_rutinaSeleccionada[juego.id]?.nombre}');
    }
    setState(() {});
  }

  void _seleccionarRutina(int juegoId, Rutina rutina) async {
    setState(() {
      _rutinaSeleccionada[juegoId] = rutina;
    });
    await DatabaseService().saveRutinaSeleccionada(widget.perfil.id, rutina.id, juegoId);
    print('Rutina seleccionada para juego $juegoId: ${rutina.nombre}');
  }

  @override
  Widget build(BuildContext context) {
    return DrawerClase.buildScaffold(
      context: context,
      title: 'Seleccionar Rutina',
      body: ListView.builder(
        itemCount: widget.juegos.length,
        itemBuilder: (context, index) {
          final juego = widget.juegos[index];
          return _buildJuegoCard(context, juego);
        },
      ),
      perfil: widget.perfil,
      perfiles: widget.perfiles,
      juegos: widget.juegos,
    );
  }

  Widget _buildJuegoCard(BuildContext context, Juego juego) {
    final rutinas = juego.rutinas.take(3).toList();
    final rutinaSeleccionada = _rutinaSeleccionada[juego.id];

    return Card(
      margin: EdgeInsets.all(10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              juego.nombre,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(height: 10),
            ...rutinas.map((rutina) => _buildRutinaTile(context, juego, rutina, rutinaSeleccionada)).toList(),
            if (rutinaSeleccionada != null)
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  'Rutina seleccionada: ${rutinaSeleccionada.nombre}',
                  style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildRutinaTile(BuildContext context, Juego juego, Rutina rutina, Rutina? rutinaSeleccionada) {
    final bool isSelected = rutinaSeleccionada == rutina;

    return ListTile(
      leading: Icon(
        isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
        color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
      ),
      title: Text(rutina.nombre),
      subtitle: Text(rutina.descripcion),
      onTap: () => _seleccionarRutina(juego.id, rutina),
    );
  }
}
