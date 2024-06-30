import 'package:flutter/material.dart';

class ConfiguracionListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const ConfiguracionListTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.deepPurple[900]),
      title: Text(title, style: TextStyle(color: Colors.deepPurple[900])),
      onTap: onTap,
    );
  }
}
