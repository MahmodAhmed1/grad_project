import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:pyramend/task_management/viewModel/cubit/task_cubit.dart';

class DurationField extends StatelessWidget {
  final TextEditingController controller;

  const DurationField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Estimate Task",
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
            suffixIcon: const Icon(Icons.access_time_rounded),
            filled: true,
            fillColor: const Color.fromARGB(255, 240, 240, 240),
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
          ),
          onTap: () async {
            Duration? selectedDuration = await showDurationPicker(
              context: context,
              initialTime: const Duration(hours: 0, minutes: 0),
            );
            if (selectedDuration != null) {
              TaskCubit cubit = TaskCubit.get(context);
              cubit.setDuration(selectedDuration);
              int hours = cubit.duration.inHours;
              int minutes = cubit.duration.inMinutes.remainder(60);
              controller.text = "${hours * 60 + minutes}";
            }
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "0";
            }
            return null;
          },
        ),
      ],
    );
  }
}
