import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  final String gender;

  const ProfileImage({Key? key, required this.gender}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            Colors.green,
            Color.fromARGB(255, 230, 230, 230),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: ClipOval(
        child: Image.asset(
          gender == 'male' ? 'assets/imgs/male.png' : 'assets/imgs/female.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
