import 'package:flutter/material.dart';
import 'package:pyramend/shared/componenets/common_widgets/buttons.dart';
import '../authentication/views/log_in.dart';
import '../shared/styles/colors/colors.dart';

class OnboardingPage1 extends StatefulWidget {
  @override
  _OnboardingPage1State createState() => _OnboardingPage1State();
}

class _OnboardingPage1State extends State<OnboardingPage1>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int currentIndex = 0;

  List<OnboardingData> onboardingData = [
    OnboardingData(
      image: 'assets/imgs/on_fig1.png',
      title: 'Get Fit',
      description:
          'Do you want to build more muscles or lose weight ?\n...\nReach your goal',
      backgroundColor: [
        const Color(0xFF677ADC),
        const Color(0xFFEC8CA9),
      ],
    ),
    OnboardingData(
      image: 'assets/imgs/on_fig2.png',
      title: 'Eat Well',
      description:
          ' Start a healthy lifestyle , You can determine your diet every day\n...\nhealthy food is fun',
      backgroundColor: [
        const Color(0xFFF4F696),
        const Color(0xFFE6877A),
      ],
    ),
    OnboardingData(
      image: 'assets/imgs/on_fig3.png',
      title: 'Be More Productive',
      description:
          'Improve the quality of your work, study and more\n...\n Be focus on your goal without disturbance',
      backgroundColor: [
        const Color(0xFF8FEDE2),
        const Color(0xFF9DCEFF),
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Ucolor.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                  child: const Text(
                    'What is your goal ?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      height: 1.5,
                      color: Color(0xFF1D1617),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 0, 18.2, 0),
                  child: const Text(
                    'We can help you track your goals',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      height: 1.5,
                      color: Color(0xFF7B6F72),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _buildOnboardingContainer(),
                const SizedBox(height: 20),
                RoundedButton(
                  width: double.maxFinite,
                  title: currentIndex == onboardingData.length - 1
                      ? 'Finish'
                      : 'Next',
                  backgroundColor: Ucolor.DarkGray,
                  textColor: Ucolor.white,
                  onPressed: () {
                    if (currentIndex < onboardingData.length - 1) {
                      setState(() {
                        currentIndex++;
                        _controller.reset();
                        _controller.forward();
                      });
                    } else {
                      // Navigate to the next page after finishing onboarding
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LogIn()),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOnboardingContainer() {
    if (currentIndex == 0) {
      return _buildOnboardingContent(0);
    } else {
      return Stack(
        children: [
          ClipRect(
            child: SlideTransition(
              position: Tween<Offset>(
                begin: Offset.zero,
                end: const Offset(-1.0, 0.0),
              ).animate(_controller),
              child: _buildOnboardingContent(currentIndex - 1),
            ),
          ),
          SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(_controller),
            child: _buildOnboardingContent(currentIndex),
          ),
        ],
      );
    }
  }

  Widget _buildOnboardingContent(int index) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: onboardingData[index].backgroundColor,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: SizedBox(
        width: 340,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 35, 0, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 2.4, 24.8),
                child: SizedBox(
                  width: 200,
                  height: 290.2,
                  child: Image.asset(
                    onboardingData[index].image,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 2, 3),
                    child: Text(
                      onboardingData[index].title,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        height: 1.5,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 1, 21),
                    width: 50,
                    height: 1,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFFF7F8F8),
                      ),
                      child: Container(
                        width: 50,
                        height: 1,
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      onboardingData[index].description,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        height: 1.5,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OnboardingData {
  final String image;
  final String title;
  final String description;
  final List<Color> backgroundColor;

  OnboardingData({
    required this.image,
    required this.title,
    required this.description,
    required this.backgroundColor,
  });
}
