import 'package:flutter/material.dart';

class WaterConsumptionDisplay extends StatelessWidget {
  final String text;

  const WaterConsumptionDisplay({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18.0,
        color: Color(0xFF046381),
        fontWeight: FontWeight.bold,
        fontFamily: "",
      ),
    );
  }
}
