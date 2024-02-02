import 'package:flutter/material.dart';
import 'package:prostate_care/global_comonents/custom_button.dart';
import 'package:prostate_care/main_screens/main_screen.dart';
import 'package:prostate_care/settings/constants.dart';

class QuestionPopup extends StatefulWidget {
  const QuestionPopup({super.key, r});
  @override
  State<QuestionPopup> createState() => _QuestionPopupState();
}

class _QuestionPopupState extends State<QuestionPopup> {
  final TextEditingController _qController = TextEditingController();
  final TextEditingController _uController = TextEditingController();
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 240,
        child: Center(
          child: Container(
            height: 170,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Question sent!",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "You’ll receive the answer in your mail as soon as possible.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Constants.grey),
                ),
                CustomButton(
                    height: 50,
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, MainScreen.id, (route) => false);
                    },
                    title: "Back to Home")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
