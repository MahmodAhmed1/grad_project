import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SlidableActionWidget extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final VoidCallback onPressed;

  const SlidableActionWidget({
    required this.icon,
    required this.color,
    required this.label,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlidableAction(
      onPressed: (context) => onPressed(),
      backgroundColor: Colors.white,
      foregroundColor: color,
      icon: icon,
      label: label,
      spacing: 2,
    );
  }
}
