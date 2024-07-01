
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../styles/colors/colors.dart';

class SelectableBox extends StatefulWidget {
  final String text;
  final String iconPath;
  final bool isSelected;
  final VoidCallback onTap;

  const SelectableBox({
    required this.text,
    required this.iconPath,
    required this.isSelected,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  _SelectableBoxState createState() => _SelectableBoxState();
}

class _SelectableBoxState extends State<SelectableBox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: widget.isSelected ? Color(0xFF1BD15D) : Ucolor.lightGray,
          borderRadius: BorderRadius.circular(15),
        ),
        width: 100,
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              widget.iconPath,
              width: 50,
              height: 50,
              color: widget.isSelected ? Colors.white : Ucolor.gray,
            ),
            SizedBox(height: 8.0),
            Text(
              widget.text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: widget.isSelected ? Colors.white : Ucolor.gray,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
