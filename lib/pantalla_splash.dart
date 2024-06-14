import 'package:flutter/material.dart';
import 'pantalla_inicio.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    logger.i('didChangeDependencies SplashScreen');
  }

  @override
  void didUpdateWidget(SplashScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    logger.i('didUpdateWidget SplashScreen');
  }

  @override
  void deactivate() {
    logger.i('deactivate SplashScreen');
    super.deactivate();
  }

  @override
  void dispose() {
    logger.i('dispose SplashScreen');
    super.dispose();
  }

  @override
  void reassemble() {
    super.reassemble();
    logger.i('reassemble SplashScreen');
  }

  void _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3), () {});
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PantallaInicio()),
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
