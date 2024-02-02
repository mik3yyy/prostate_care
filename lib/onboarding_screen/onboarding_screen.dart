import 'package:flutter/material.dart';
import 'package:prostate_care/auth/sign_up/sign_up.dart';
import 'package:prostate_care/global_comonents/custom_button.dart';
import 'package:prostate_care/global_comonents/custom_text_button.dart';
import 'package:prostate_care/settings/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  static String id = "/onboarding";
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;
  // @override
  // void initState() {
  //   super.initState();

  //   _pageController.addListener(() {
  //     setState(() {
  //       _currentIndex = _pageController.page!.toInt();
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.sizeOf(context).height * .8,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.05, 0.8],
                // transform: GradientRotation(0),
                colors: [
                  Color(0xFF3E64FF), // Lighter blue color at the top
                  Constants.white, // Darker blue color at the bottom
                ],
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: <Widget>[
                    Constants.gap(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmoothPageIndicator(
                          controller: _pageController,
                          count: 3,
                          effect: WormEffect(
                              activeDotColor: Constants.primaryBlue,
                              dotColor: Constants.lightBlue,
                              dotHeight: 4,
                              dotWidth: 20,
                              radius: 4),
                        ),
                        CustomTextButton(
                          text: "Skip",
                          onPressed: () {
                            Navigator.pushNamed(context, SignUpScreen.id);
                          },
                          underlined: true,
                          color: Constants.white,
                        ),
                      ],
                    ),
                    Expanded(
                      child: PageView(
                        controller: _pageController,
                        onPageChanged: (value) {
                          setState(() {
                            _currentIndex = value;
                          });
                        },
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: 260,
                                height: 360.51,
                                child: Image.asset(
                                  'assets/images/onboarding/onboarding.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Constants.gap(height: 40),
                              Container(
                                width: MediaQuery.sizeOf(context).width * 0.9,
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    style: Constants.Montserrat.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                    ),
                                    children: [
                                      TextSpan(
                                        text:
                                            'Musa wants the lowdown on Prostate Cancer, so he turns to ProstateCARE to ',
                                        style: Constants.Montserrat.copyWith(
                                          color: Constants.black,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'calculate',
                                        style: Constants.Montserrat.copyWith(
                                          color: Constants.teal,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' his chances of having it. ',
                                        style: Constants.Montserrat.copyWith(
                                          color: Constants.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: 260,
                                height: 360.51,
                                child: Image.asset(
                                  'assets/images/onboarding/onboarding-2.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Constants.gap(height: 40),
                              Container(
                                width: MediaQuery.sizeOf(context).width * 0.9,
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    style: Constants.Montserrat.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                    ),
                                    children: [
                                      TextSpan(
                                        text:
                                            'He also uses ProstateCARE to help him out with. ',
                                        style: Constants.Montserrat.copyWith(
                                          color: Constants.black,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'medical reminders',
                                        style: Constants.Montserrat.copyWith(
                                          color: Constants.teal,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            ' He gets to edit or delete them when he wants',
                                        style: Constants.Montserrat.copyWith(
                                          color: Constants.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: 260,
                                height: 360.51,
                                child: Image.asset(
                                  'assets/images/onboarding/onboarding-3.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Constants.gap(height: 40),
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  style: Constants.Montserrat.copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                          'He also gets to read more on Prostate cancer, through ',
                                      style: Constants.Montserrat.copyWith(
                                        color: Constants.black,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'articles and blogs.',
                                      style: Constants.Montserrat.copyWith(
                                        color: Constants.teal,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' Do you want to be like Musa? ',
                                      style: Constants.Montserrat.copyWith(
                                        color: Constants.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomButton(
              onTap: _currentIndex == 2
                  ? () {
                      Navigator.pushNamed(context, SignUpScreen.id);
                    }
                  : () {
                      // setState(() {});
                      _pageController.nextPage(
                          duration: Duration(milliseconds: 400),
                          curve: Curves.easeIn);
                    },
              title: _currentIndex == 2 ? "Yes! Get started" : "Proceed",
            ),
          )
        ],
      ),
    );
  }
}
