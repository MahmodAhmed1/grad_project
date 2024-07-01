import 'package:flutter/material.dart';

class CategoryContainer extends StatelessWidget {
  final Map<String, dynamic> task;
  final dynamic cubit;

  const CategoryContainer({required this.task, required this.cubit, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print("category Container"),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: cubit.categoryColorList[task["category"]]?.color,
        ),
        constraints: const BoxConstraints(
          minWidth: 88.0,
          minHeight: 36.0,
        ),
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              cubit.categoryColorList[task["category"]]?.iconData,
              color: Colors.white,
              size: 18,
            ),
            const SizedBox(width: 5),
            Text(
              task["category"],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
