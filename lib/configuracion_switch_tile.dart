import 'package:flutter/material.dart';

class ConfiguracionSwitchTile extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color activeColor;

  const ConfiguracionSwitchTile({
    Key? key,
    required this.title,
    required this.value,
    required this.onChanged,
    required this.activeColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      activeColor: activeColor,
      title: Text(title, style: TextStyle(color: Colors.deepPurple[900])),
      value: value,
      onChanged: onChanged,
    );
  }
}
