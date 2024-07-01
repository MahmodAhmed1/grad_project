import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  final String imagePath;
  const SquareTile({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(221, 218, 218, 1)),
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: Image.asset(
        imagePath,
        height: 25,
        width: 25,
      ),
    );
  }
}
