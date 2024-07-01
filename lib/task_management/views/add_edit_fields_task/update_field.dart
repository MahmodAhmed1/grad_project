import 'package:flutter/material.dart';
import 'package:pyramend/task_management/shared/constants/colors.dart';

class UpdateButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final VoidCallback onPressed;

  const UpdateButton({required this.formKey, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 63,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: mainButtonColor,
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: const Text(
          "Update",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
