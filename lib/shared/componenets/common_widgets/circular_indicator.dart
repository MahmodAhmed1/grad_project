import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pyramend/shared/styles/colors/colors.dart';

class CircularIndicator extends StatelessWidget {
  const CircularIndicator(
      {super.key,
      required this.unit,
      required this.goal,
      required this.value,
      required this.GradientBackgroundColor,
      required this.indicatorColor});
  final String unit;
  final int goal;
  final int value;
  final List<Color> GradientBackgroundColor;
  final Color indicatorColor;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final containerSize = screenWidth / 2.5;
    return Container(
      width: containerSize,
      height: containerSize,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(colors: GradientBackgroundColor),
      ),
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.01),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              unit,
              style: TextStyle(
                color: Ucolor.lightGray,
                fontSize: screenWidth * 0.04,
                fontWeight: FontWeight.w600,
              ),
            ),
            RichText(
              text: TextSpan(
                text: '$value',
                style: TextStyle(
                  fontSize: screenWidth * 0.035,
                  fontWeight: FontWeight.w600,
                  color: Ucolor.lightGray,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: '/$goal',
                    style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      fontWeight: FontWeight.w400,
                      color: Ucolor.lightGray,
                    ),
                  ),
                  TextSpan(
                    text: unit,
                    style: TextStyle(
                      fontSize: screenWidth * 0.03,
                      fontWeight: FontWeight.w400,
                      color: Ucolor.lightGray,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: containerSize * 0.5,
                    height: containerSize * 0.5,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Ucolor.DarkGray,
                    ),
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${(goal - value > 0) ? goal - value : 'Done'}',
                            style: TextStyle(
                                color: Ucolor.lightGray,
                                fontSize: screenWidth * 0.03,
                                fontWeight: FontWeight.w600)),
                        Text(
                          '${(goal - value > 0) ? '$unit left' : ''}',
                          style: TextStyle(
                            color: Ucolor.lightGray,
                            fontSize: screenWidth * 0.02,
                          ),
                        )
                      ],
                    )),
                  ),
                  CircularPercentIndicator(
                    radius: containerSize * 0.35,
                    lineWidth: containerSize * 0.08,
                    percent: (value / goal > 1) ? 1 : value / goal,
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: Ucolor.gray,
                    backgroundColor: Ucolor.lightGray,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
