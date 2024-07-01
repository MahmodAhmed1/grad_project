import 'package:flutter/material.dart';
import 'package:pyramend/shared/styles/colors/colors.dart';

import '../authentication/views/sign_up.dart';
import '../shared/componenets/common_widgets/buttons.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  PageController controller = PageController();

  @override
  void initState() {
    super.initState();
    _navigateHome();
  }

  _navigateHome() async {

  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Ucolor.white,
      body: Container(
        width: media.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: Ucolor.primaryG,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Image.asset(
                  'assets/imgs/logo.png',
                  width: 150,
                  height: 150,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Pyra",
                      style: TextStyle(
                          color: Ucolor.white,
                          fontSize: 36,
                          fontWeight: FontWeight.w700),
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "M",
                            style: TextStyle(
                              color: Color(0xFF31C48D).withOpacity(1.0),
                              // 100% opacity
                              fontSize: 50,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: "e",
                            style: TextStyle(
                              color: Color(0xFF31C48D).withOpacity(0.9),
                              // 20% opacity
                              fontSize: 50,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: "n",
                            style: TextStyle(
                              color: Color(0xFF31C48D).withOpacity(0.8),
                              // 20% opacity
                              fontSize: 50,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: "d",
                            style: TextStyle(
                              color: Color(0xFF31C48D).withOpacity(0.7),
                              // 20% opacity
                              fontSize: 50,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Text(
                  "Track Your Goals",
                  style: TextStyle(
                    color: Ucolor.gray,
                    fontSize: 18,
                  ),
                ),
                const Spacer(),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: RoundedButton(
                      width: double.maxFinite,
                      title: 'Get Started',
                      backgroundColor: Ucolor.white,
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => SignUp()));
                      },
                    )
                    // MaterialButton(
                    //   textColor: Ucolor.primaryColor1,
                    //   minWidth: double.maxFinite,
                    //   height: 60,
                    //   color: Ucolor.white,
                    //   shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(25)),
                    //   // navigate to home page for now
                    //   onPressed: () {
                    //
                    //   },
                    //   child: ShaderMask(
                    //     shaderCallback: (bounds) {
                    //       return LinearGradient(
                    //         begin: Alignment.centerLeft,
                    //         end: Alignment.centerRight,
                    //         colors: Ucolor.primaryG,
                    //       ).createShader(bounds);
                    //     },
                    //     child: Text(
                    //       "Get Started",
                    //       style: TextStyle(
                    //         color: Ucolor.primaryColor1,
                    //         fontSize: 16,
                    //         fontWeight: FontWeight.w700,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    ),
                SizedBox(
                  height: 25,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
