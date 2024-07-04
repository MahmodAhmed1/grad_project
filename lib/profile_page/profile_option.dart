import 'package:flutter/material.dart';

class ProfileOption extends StatelessWidget {
  final dynamic icon;
  final String label;
  final Widget destination;

  const ProfileOption({
    Key? key,
    required this.icon,
    required this.label,
    required this.destination,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(4),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              icon is IconData
                  ? Icon(icon)
                  : SizedBox(
                      width: 25,
                      child: Image.asset(
                        icon,
                        fit: BoxFit.cover,
                      ),
                    ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(label),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
