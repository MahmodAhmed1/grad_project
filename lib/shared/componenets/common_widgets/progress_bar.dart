import 'package:flutter/material.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:pyramend/shared/styles/colors/colors.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    super.key,
    required this.title,
    required this.percentage,
  });

  final String title;
  final double percentage;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Ucolor.gray,
                ),
              ),
              RichText(
                text: TextSpan(
                  text: '${(percentage * 100).ceil()}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Ucolor.DarkGray,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: '%',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Ucolor.gray,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 7,
          width: double.infinity,
          child: GFProgressBar(
            animation: true,
            circleWidth: 10,
            radius: 20,
            lineHeight: 6,
            margin: const EdgeInsets.only(left: 0),
            percentage: percentage,
            backgroundColor: Ucolor.lightGray,
            linearGradient: LinearGradient(
              colors: Ucolor.fitnessPrimaryColors,
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
      ],
    );
  }
}
