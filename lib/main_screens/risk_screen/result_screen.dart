import 'package:flutter/material.dart';
import 'package:prostate_care/global_comonents/custom_button.dart';
import 'package:prostate_care/main_screens/main_screen.dart';
import 'package:prostate_care/settings/constants.dart';
import 'package:speedometer_chart/speedometer_chart.dart';

class ResulScreen extends StatefulWidget {
  const ResulScreen({super.key, required this.result});
  final double result;
  @override
  State<ResulScreen> createState() => _ResulScreenState();
}

class _ResulScreenState extends State<ResulScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          const Text(
            "Result",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          Constants.gap(width: 20),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SpeedometerChart(
                dimension: 200,
                minValue: 0,
                maxValue: 100,
                // valueFixed: 1,
                value: widget.result, //getiniScore(),
                minTextValue: '',
                maxTextValue: '',
                graphColor: [Colors.red, Colors.yellow, Colors.green],
                pointerColor: Colors.black,
                valueVisible: false,
                rangeVisible: true,
              ),
            ),
            // Center(
            //     child: Container(
            //         height: 200, child: Image.asset('assets/images/risk.png'))),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: Constants.Montserrat.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
                children: [
                  TextSpan(
                    text: 'Result ',
                    style: Constants.Montserrat.copyWith(
                      color: Constants.black,
                    ),
                  ),
                  TextSpan(
                    text: "${widget.result.toString()}%",
                    style: Constants.Montserrat.copyWith(
                      color: Constants.teal,
                    ),
                  ),
                ],
              ),
            ),
            Constants.gap(height: 20),
            Text(
                "The chance to find prostate cancer withfurther study as indicated on the outside ring is 8%.\nIf your risk falls into the white area, you have a lower than average risk of finding prostate cancer with further study. If your risk is in the yellow area, you might consider consulting your family physician to have the PSA content determined in your blood. Some family physicians will also carry out a rectal examination to determine if your prostate is normal to palpation.\nIf you know your PSA level, select Risk Calculator 2. You can access this from the top right of this panel."),
            Constants.gap(height: 20),
            CustomButton(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, MainScreen.id, (route) => false);
              },
              title: "Go Home",
            ),
          ],
        ),
      ),
    );
  }
}
