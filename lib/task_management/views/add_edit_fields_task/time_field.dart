import 'package:flutter/material.dart';
import 'package:pyramend/task_management/shared/constants/icons.dart';

class TimeField extends StatelessWidget {
  final TextEditingController controller;

  const TimeField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Time",
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
            suffixIcon: arrowForwardIcon,
            filled: true,
            fillColor: const Color.fromARGB(255, 240, 240, 240),
            contentPadding: const EdgeInsets.symmetric(horizontal: 22),
          ),
          onTap: () {
            showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            ).then((value) {
              if (value != null) {
                controller.text = value.format(context).toString();
              }
            });
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select a time';
            }
            return null;
          },
        ),
      ],
    );
  }
}
