import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateField extends StatelessWidget {
  final TextEditingController controller;

  const DateField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Due Date",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          readOnly: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
            suffixIcon: const Icon(Icons.calendar_today_rounded),
            filled: true,
            fillColor: const Color.fromARGB(255, 240, 240, 240),
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
          ),
          onTap: () {
            showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2024, 1),
              lastDate: DateTime(2024, 8),
            ).then((value) {
              if (value != null) {
                controller.text = DateFormat.yMMMd().format(value);
              }
            });
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select a date';
            }
            return null;
          },
        ),
      ],
    );
  }
}
