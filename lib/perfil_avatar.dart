import 'package:flutter/material.dart';
import '../models/perfil.dart';

class PerfilAvatar extends StatelessWidget {
  final Perfil perfil;

  const PerfilAvatar({super.key, required this.perfil});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurple[100],
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: CircleAvatar(
          backgroundImage: AssetImage(perfil.avatarUrl),
          radius: 40,
        ),
      ),
    );
  }
}
