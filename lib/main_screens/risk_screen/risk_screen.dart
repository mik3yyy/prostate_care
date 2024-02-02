import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:prostate_care/global_comonents/custom_button.dart';
import 'package:prostate_care/main_screens/risk_screen/calculate_risk.dart';
import 'package:prostate_care/main_screens/risk_screen/pop_up.dart';
import 'package:prostate_care/providers/auth_provider.dart';
import 'package:prostate_care/settings/constants.dart';
import 'package:provider/provider.dart';

class RiskScreen extends StatefulWidget {
  const RiskScreen({super.key});

  @override
  State<RiskScreen> createState() => _RiskScreenState();
}

class _RiskScreenState extends State<RiskScreen> {
  String result = '';

  getLastResult() {
    var riskBox = Hive.box('riskBox');
    result = riskBox.get("riskKey").toString();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLastResult();
  }

  @override
  Widget build(BuildContext context) {
    var authProvider =
        Provider.of<AuthenticationProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: Container(),
        leadingWidth: 0,
        title: Container(
          padding: EdgeInsets.only(left: 16),
          height: 50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hi ${authProvider.user!.fullName.split(' ')[0]},",
                style: TextStyle(
                  fontSize: 18,
                  color: Constants.black,
                ),
              ),
              Text(
                "Let's calculate your risk",
                style: TextStyle(
                  fontSize: 14,
                  color: Constants.grey,
                ),
              )
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await showDialog<void>(
                  context: context, builder: (context) => DisclamerPopup());
            },
            icon: Icon(
              Icons.info_outline,
              color: Constants.teal,
            ),
          ),
          Constants.gap(width: 16)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Constants.gap(height: 30),
            Center(child: Image.asset("assets/images/auth/bow-3.png")),
            Constants.gap(height: 10),
            if (result != "null") ...[
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: Constants.Montserrat.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                  ),
                  children: [
                    TextSpan(
                      text: 'Your last result: ',
                      style: Constants.Montserrat.copyWith(
                        color: Constants.black,
                      ),
                    ),
                    TextSpan(
                      text: "${result.toString()}%",
                      style: Constants.Montserrat.copyWith(
                        color: Color(0xFFB20000),
                      ),
                    ),
                  ],
                ),
              ),
              Constants.gap(height: 10),
            ],
            Text(
                "Risk calculator 1 – the general health calculator is a starting point, looking at family history, age and any medical problems with urination."),
            Constants.gap(height: 10),
            Text(
                "With this calculator, all you will need to give is your age and any problems you are having with urination. It will also ask you about whether your immediate relatives (brother, father or uncle on your father's or mother's side) have suffered from prostate cancer. Don’t worry if you don’t know if anyone in your family has suffered from prostate cancer, just put 'No' in the table."),
            Constants.gap(height: 30),
            CustomButton(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CalculateRiskScreen()));
              },
              title: "Start the calculator",
            ),
          ],
        ),
      ),
    );
  }
}
