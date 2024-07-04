import 'package:flutter/material.dart';
import 'package:pyramend/authentication/views/provider.dart';
import 'package:pyramend/profile_page/profile_option.dart';
// import '../../authentication/views/provider.dart';
import 'package:provider/provider.dart';

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
          InkWell(
            onTap: () {
              Provider.of<UserProvider>(context, listen: false)
                  .clearLoginState(context);
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
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.logout),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text("User Logout"),
                    ),
                    Icon(
                      Icons.chevron_right_rounded,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox sizedBoxHeight(double height) {
    return SizedBox(height: height);
  }
}

SizedBox sizedBoxWidth(double width) {
  return SizedBox(width: width);
}
