import 'package:flutter/material.dart';
import 'home.dart';
import 'package:logger/logger.dart';

final logger = Logger();

final ThemeData theme = ThemeData(
  primarySwatch: Colors.deepPurple,
  primaryColor: Colors.deepPurple,
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.deepPurple,
  ).copyWith(
    secondary: Colors.deepOrange,
  ),
  scaffoldBackgroundColor: Colors.blue.shade50,
  textTheme: TextTheme(
    headlineSmall: const TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
    titleLarge: const TextStyle(color: Colors.deepPurple),
    titleMedium: TextStyle(color: Colors.deepPurple.shade700),
    bodyLarge: TextStyle(color: Colors.deepPurple.shade900),
    bodyMedium: TextStyle(color: Colors.deepPurple.shade600),
  ),
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E_SPORT_GAMERSTALCA',
      theme: theme,
      home: const Home(),
    );
  }
}
