import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:prostate_care/main_screens/main_screen.dart';
import 'package:prostate_care/onboarding_screen/onboarding_screen.dart';
import 'package:prostate_care/providers/auth_provider.dart';
import 'package:prostate_care/providers/reminder_provider.dart';
import 'package:prostate_care/settings/constants.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static String id = "/splash";
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool loadScreen = false;

  // init(BuildContext context) async {
  //   Future.delayed(Duration(seconds: 4), () async {
  //     var box = await Hive.openBox<Donor>('donorBox');
  //   });
  // }

  void splash(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {}).then((value) {
      // Navigator.pushNamed(context, OnboardingScreen.id);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // HiveFunction.deleteToken();
    var authProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    var reminderProvider =
        Provider.of<ReminderProvider>(context, listen: false);
    reminderProvider.getReminder();
    var userBox = Hive.box('userBox');

    Future.delayed(Duration(seconds: 2), () async {
      var user = await userBox.get('userKey');

      if (user != null) {
        authProvider.saveUser(user);
        print(user.toString());
        Navigator.pushReplacementNamed(context, MainScreen.id);
      } else {
        Navigator.pushReplacementNamed(context, OnboardingScreen.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Constants.primaryBlue,
        body: Column(
          children: [
            Expanded(
              child: Center(
                child: Image.asset('assets/images/onboarding/splash.png'),
              ),
            ),
            Container(
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "PROSTATE CARE",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Constants.white,
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
