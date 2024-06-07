import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  // Añadir key al constructor
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
      ),
      body: const Center(
        child: Text('Menu Screen'),
      ),
    );
  }
}
