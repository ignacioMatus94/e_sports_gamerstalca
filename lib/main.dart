import 'package:e_sports_gamerstalca/splashScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E_SPORT_GAMERSTALCA',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFF1565C0), // Azul oscuro
          secondary: const Color(0xFF81D4FA), // Azul claro
          background: const Color(0xFFE3F2FD), // Fondo azul muy claro
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(color: Color(0xFF1565C0), fontSize: 24, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(color: Color(0xFF4A4A4A), fontSize: 18),
          bodyMedium: TextStyle(color: Color(0xFF9B9B9B), fontSize: 16),
        ),
      ),
      home: const SplashScreen(), // Pantalla de splash personalizada
    );
  }
}
