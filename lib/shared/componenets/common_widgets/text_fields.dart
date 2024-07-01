import 'package:flutter/material.dart';
import 'package:pyramend/shared/componenets/constants/constants.dart';
import 'package:pyramend/shared/styles/colors/colors.dart';

class RoundedTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String hintText;
  final String? prefixIconPath;
  late final bool obscureText;
  late Widget? suffixIcon;
  final EdgeInsets? margin;
  final TextInputType? keyboardType;
  final List<String>? dropdownItems;
  final ValueChanged<String?>? onChanged;
  final String? Function(String?)? validator;

  RoundedTextField({
    this.controller,
    this.margin,
    this.obscureText = false,
    this.keyboardType,
    required this.hintText,
    this.prefixIconPath = '',
    this.suffixIcon,
    this.dropdownItems,
    this.onChanged,
    this.validator,
  });

  @override
  _RoundedTextFieldState createState() => _RoundedTextFieldState();
}

class _RoundedTextFieldState extends State<RoundedTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      decoration: BoxDecoration(
        color: Ucolor.lightGray,
        borderRadius: BorderRadius.circular(15),
      ),
      child: widget.dropdownItems != null
          ? InputDecorator(
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                hintText: widget.hintText,
                hintStyle:
                    TextStyle(color: Ucolor.gray, fontSize: smallFotSize),
                prefixIcon: Container(
                  width: iconWidth,
                  height: iconHeight,
                  alignment: Alignment.center,
                  child: Image.asset(
                    widget.prefixIconPath!,
                    width: iconWidth,
                    height: iconHeight,
                    fit: BoxFit.contain,
                    color: Ucolor.gray,
                  ),
                ),
                border: InputBorder.none,
              ),
              child: DropdownButtonFormField<String>(
                value: widget.controller?.text,
                items: [
                  DropdownMenuItem<String>(
                    value: null,
                    child: Text(
                      widget.hintText,
                      style:
                          TextStyle(color: Ucolor.gray, fontSize: smallFotSize),
                    ),
                  ),
                  if (widget.dropdownItems != null)
                    ...widget.dropdownItems!
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                ],
                onChanged: widget.onChanged,
                decoration: InputDecoration.collapsed(hintText: ''),
              ),
            )
          : TextFormField(
              controller: widget.controller,
              obscureText: _obscureText,
              keyboardType: widget.keyboardType,
              validator: widget.validator,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: widget.hintText,
                prefixIcon: Container(
                  width: iconWidth,
                  height: iconHeight,
                  alignment: Alignment.center,
                  child: Image.asset(
                    widget.prefixIconPath!,
                    width: iconWidth,
                    height: iconHeight,
                    fit: BoxFit.contain,
                    color: Ucolor.gray,
                  ),
                ),
                suffixIcon: widget.obscureText
                    ? IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Ucolor.gray,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      )
                    : null,
                hintStyle:
                    TextStyle(color: Ucolor.gray, fontSize: smallFotSize),
              ),
            ),
    );
  }
}
