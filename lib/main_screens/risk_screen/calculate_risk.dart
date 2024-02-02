import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:prostate_care/global_comonents/custom_button.dart';
import 'package:prostate_care/global_comonents/custom_messageHandler.dart';
import 'package:prostate_care/main_screens/risk_screen/result_screen.dart';
import 'package:prostate_care/main_screens/risk_screen/rist_function.dart';
import 'package:prostate_care/settings/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:speedometer_chart/speedometer_chart.dart';

class CalculateRiskScreen extends StatefulWidget {
  const CalculateRiskScreen({super.key});

  @override
  State<CalculateRiskScreen> createState() => _CalculateRiskScreenState();
}

class _CalculateRiskScreenState extends State<CalculateRiskScreen> {
  List<int> scores = [0, 0, 0, 0, 0, 0, 0, 0, 0];
  List<int> options = [-1, -1, -1, -1, -1, -1, -1, -1];

  List<Map<String, dynamic>> questions = RiskFunction.questions;
  PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  double g_value = 0;

  @override
  Widget build(BuildContext context) {
    // double getiniScore() {
    //   double count = 0;
    //   double sum = 0;
    //   for (int ii = 0; ii < options.length; ii++) {
    //     if (options[ii] != -1) {
    //       count = count + 1;
    //       sum += scores[ii];
    //     }
    //   }
    //   return count == 0 ? 0 : sum / count;
    // }

    return ScaffoldMessenger(
      key: scaffoldKey,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            const Text(
              "questions",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Constants.gap(width: 20),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              // Center(
              //   child: Container(
              //       height: 200, child: Image.asset('assets/images/risk.png')),
              // ),
              SpeedometerChart(
                dimension: 200,
                minValue: 0,
                maxValue: 100,
                // valueFixed: 1,
                value: g_value, //getiniScore(),
                minTextValue: '',
                maxTextValue: '',
                graphColor: [Colors.red, Colors.yellow, Colors.green],
                pointerColor: Colors.black,
                valueVisible: false,
                // rangeVisible: true,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: questions.length,
                    effect: WormEffect(
                        activeDotColor: Constants.primaryBlue,
                        dotColor: Constants.lightBlue,
                        dotHeight: 4,
                        dotWidth: 20,
                        radius: 4),
                  ),
                ],
              ),
              Constants.gap(height: 20),
              Expanded(
                  child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    _currentIndex = value;
                  });
                },
                controller: _pageController,
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> question = questions[index];

                  // int option = options[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        question['title'],
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      Constants.gap(height: 10),
                      Text(question['question']),
                      Constants.gap(height: 10),
                      Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount:
                                      2, // Adjust the number of items per row
                                  crossAxisSpacing: 10, // Spacing between items
                                  mainAxisSpacing: 20,
                                  mainAxisExtent: 40),
                          itemCount: question['option'],
                          itemBuilder: (context, index2) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  options[index] = index2;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: options[index] == index2
                                      ? Constants.purple
                                      : Color(0xFFF8F8F8),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    question['options'][index2]['option'],
                                    style: TextStyle(
                                      color: options[index] == index2
                                          ? Constants.white
                                          : Constants.black,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  );
                },
              )),
            ],
          ),
        ),
        bottomSheet: Container(
          height: 140,
          child: Column(
            children: [
              CustomButton(
                onTap: _currentIndex == questions.length - 1
                    ? () {
                        bool o = options.any((element) => element == -1);
                        if (o) {
                          return MyMessageHandler.showSnackBar(
                              scaffoldKey, "Choose all options");
                        } else {
                          double result = 0;

                          for (int i = 0; i < questions.length; i++) {
                            result +=
                                questions[i]['options'][options[i]]['score'];
                          }
                          result = result / questions.length;
                          var riskBox = Hive.box('riskBox');
                          riskBox.put("riskKey", result);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ResulScreen(result: result)));
                        }
                      }
                    : () {
                        double count = 0;
                        double sum = 0;
                        for (int ii = 0; ii < options.length; ii++) {
                          if (options[ii] != -1) {
                            count = count + 1;
                            sum +=
                                questions[ii]['options'][options[ii]]['score'];
                          }
                        }

                        setState(() {
                          g_value = count == 0 ? 0 : sum / count;
                        });
                        _pageController.nextPage(
                            duration: Duration(milliseconds: 400),
                            curve: Curves.easeIn);
                        setState(() {
                          _currentIndex = _pageController.page!.floor();
                        });
                      },
                title: _currentIndex == questions.length - 1
                    ? "Calculate"
                    : "Next",
                height: 50,
                color: Constants.purple,
              ),
              Constants.gap(height: 10),
              if (_currentIndex != 0)
                CustomButton(
                  height: 50,
                  onTap: () {
                    // setState(() {});
                    double count = 0;
                    double sum = 0;
                    for (int ii = 0; ii < options.length; ii++) {
                      if (options[ii] != -1) {
                        count = count + 1;
                        sum += questions[ii]['options'][options[ii]]['score'];
                      }
                    }

                    setState(() {
                      g_value = count == 0 ? 0 : sum / count;
                    });
                    _pageController.previousPage(
                        duration: Duration(milliseconds: 400),
                        curve: Curves.easeIn);
                    setState(() {
                      _currentIndex = _pageController.page!.ceil();
                    });
                  },
                  color: Constants.white,
                  border: Border.all(color: Constants.purple),
                  title: "Go back",
                  textColor: Constants.purple,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
