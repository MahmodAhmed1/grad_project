import 'package:flutter/material.dart';

class WaterAmountButton extends StatelessWidget {
  final String imagePath;
  final int amount;
  final VoidCallback onAddPressed;
  final VoidCallback onRemovePressed;

  const WaterAmountButton({
    Key? key,
    required this.imagePath,
    required this.amount,
    required this.onAddPressed,
    required this.onRemovePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          imagePath,
          width: 100,
          height: 80,
        ),
        SizedBox(
          width: 20.0, // Custom width
          height: 20.0, // Custom height
          child: FloatingActionButton(
            onPressed: onRemovePressed,
            backgroundColor: Colors.red,
            child: const Icon(Icons.remove, size: 20.0, color: Colors.white),
          ),
        ),
        ElevatedButton(
          onPressed: onAddPressed,
          child: Text('+$amount ml'),
        ),
      ],
    );
  }
}
