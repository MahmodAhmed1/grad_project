import 'package:flutter/material.dart';
import 'profile_option.dart';

class ProfileSection extends StatelessWidget {
  final String title;
  final List<ProfileOption> options;

  const ProfileSection({Key? key, required this.title, required this.options})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          sizedBoxHeight(20),
          ...options,
        ],
      ),
    );
  }

  SizedBox sizedBoxHeight(double height) {
    return SizedBox(height: height);
  }
}
