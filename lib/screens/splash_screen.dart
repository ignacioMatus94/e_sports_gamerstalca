import 'package:flutter/material.dart';
import 'home.dart'; 
import 'package:logger/logger.dart';
import '../models/perfil.dart';
import '../models/juego.dart';
import '../models/rutina.dart';

final logger = Logger();

class SplashScreen extends StatefulWidget {
  final List<Perfil> perfiles;
  final List<Juego> juegos;
  final Map<int, Rutina> rutinasSeleccionadas;

  const SplashScreen({Key? key, required this.perfiles, required this.juegos, required this.rutinasSeleccionadas}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _SplashScreenState() {
    logger.i('Constructor: _SplashScreenState');
    logger.i('mounted: $mounted');
  }

  @override
  void initState() {
    super.initState();
    logger.i('initState SplashScreen');
    _navigateToHome();
  }

  void _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3), () {});
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Home(
            juegos: widget.juegos,
            perfiles: widget.perfiles,
            rutinasSeleccionadas: widget.rutinasSeleccionadas,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    logger.i('build SplashScreen');
    return const Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.videogame_asset,
              color: Colors.white,
              size: 100,
            ),
            SizedBox(height: 20),
            Text(
              'E_SPORT_GAMERSTALCA',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
