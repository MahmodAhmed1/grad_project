import 'package:flutter/material.dart';
import 'package:pyramend/task_management/viewModel/cubit/task_cubit.dart';

class PriorityField extends StatelessWidget {
  final TaskCubit cubit;

  const PriorityField({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Priority",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildPriorityButton('high', cubit),
            _buildPriorityButton('medium', cubit),
            _buildPriorityButton('low', cubit),
          ],
        ),
      ],
    );
  }

  Widget _buildPriorityButton(String priority, TaskCubit cubit) {
    return Expanded(
      child: SizedBox(
        height: 60,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: cubit.dropdownPriorityValue == priority
                ? const Color.fromARGB(255, 126, 126, 126)
                : const Color.fromARGB(255, 240, 240, 240),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          onPressed: () {
            cubit.editPriority(priority);
          },
          child: Text(
            priority.capitalize(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: cubit.dropdownPriorityValue == priority
                  ? Colors.white
                  : Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
