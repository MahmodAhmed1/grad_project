import 'package:flutter/material.dart';

class DescriptionField extends StatelessWidget {
  final TextEditingController controller;

  const DescriptionField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Description",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: const Color.fromARGB(255, 240, 240, 240),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 22,
              vertical: 40,
            ),
          ),
          minLines: 1,
          maxLines: 5,
        ),
      ],
    );
  }
}
