import 'package:flutter/material.dart';
// import 'package:pyramend/shared/styles/colors/colors.dart';

class CircularButton extends StatelessWidget {
  final Icon? icon;
  final double height;
  final double width;
  final double boarderRadius;
  final ontap;
  final Gradient? gradient;
  final Color? backgroundColor;

  CircularButton({
    super.key,
    this.icon = null,
    this.height = 50,
    this.width = 50,
    this.boarderRadius = 50,
    this.ontap,
    this.gradient,
    this.backgroundColor,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        color: backgroundColor,
        height: height,
        width: width,
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(boarderRadius),
        ),
        child: icon,
      ),
    );
  }
}
