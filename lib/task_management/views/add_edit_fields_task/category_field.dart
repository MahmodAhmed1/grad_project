import 'package:flutter/material.dart';
import 'package:pyramend/task_management/shared/constants/icons.dart';
import 'package:pyramend/task_management/viewModel/cubit/task_cubit.dart';
import 'package:pyramend/task_management/viewModel/cubit/task_cubit.dart';

class CategoryField extends StatelessWidget {
  final TaskCubit cubit;

  const CategoryField({required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Category",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: const Color.fromARGB(255, 240, 240, 240),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 22),
          width: double.infinity,
          child: DropdownButtonFormField<String>(
            icon: arrowDownIcon,
            iconSize: 18,
            isExpanded: true,
            hint: const Text(
              "Category",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            value: cubit.dropdownCategoryValue.isEmpty
                ? null
                : cubit.dropdownCategoryValue,
            decoration: const InputDecoration(border: InputBorder.none),
            onChanged: (newValue) {
              cubit.editTag(newValue);
            },
            items: cubit.categoryTaskInput.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              );
            }).toList(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select a category';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
