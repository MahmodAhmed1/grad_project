import 'package:flutter/material.dart';
import 'package:pyramend/shared/componenets/constants/constants.dart';

class RoundedButton extends StatelessWidget {
  final String? title;
  final double titleSize;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final FontWeight? fontWeight;
  final double height;
  final double width;
  final double padding;
  final Gradient? gradient;
  final Widget? child;

  RoundedButton({
    this.title,
    this.child,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.titleSize = 16,
    this.height = 75,
    this.width = 75,
    this.padding = 15,
    this.fontWeight = FontWeight.w700,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: padding),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.blue[300]!.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: MaterialButton(
          textColor: textColor,
          minWidth: minButtonWidth,
          height: height,
          color: backgroundColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          onPressed: onPressed,
          child: child ??
              Text(
                title ?? '',
                style: TextStyle(
                  color: textColor,
                  fontSize: titleSize,
                  fontWeight: fontWeight,
                ),
              ),
        ),
      ),
    );
  }
}
