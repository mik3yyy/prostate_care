import 'package:flutter/material.dart';
import 'package:prostate_care/global_comonents/custom_button.dart';
import 'package:prostate_care/main_screens/main_screen.dart';
import 'package:prostate_care/settings/constants.dart';

class DisclamerPopup extends StatefulWidget {
  const DisclamerPopup({super.key, r});
  @override
  State<DisclamerPopup> createState() => _DisclamerPopupState();
}

class _DisclamerPopupState extends State<DisclamerPopup> {
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
        content: Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        leadingWidth: 0,
        leading: Container(),
        backgroundColor: Colors.transparent,
        title: Text(
          "DISCLAMER",
          style: TextStyle(
            color: Color(0xFFB20000),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "We want to emphasize the importance of understanding the limitations of the Prostate Cancer Risk Calculator, as it cannot guarantee a 100% accurate prediction of the presence or absence of prostate cancer. Its primary purpose is to assist in calculating risk rather than providing a conclusive diagnosis.\n\nThe first Risk Calculator takes into account general factors such as age, family history, and urinary symptoms to provide a broad risk assessment. This information serves as a valuable tool in helping individuals make informed decisions about whether to pursue further tests.\n\nFor those who are aware of their PSA level, Risk Calculator 2, available on the Rotterdam Prostate Cancer site, offers a more personalized risk assessment. To access this tool, simply drop us a message, and we will promptly provide you with the necessary information. However, it is crucial to approach the decision to undergo a PSA test with the utmost seriousness, carefully considering all factors and engaging in discussions with your GP or hospital doctor to fully understand the implications.\n\nIt is essential to note that an elevated PSA level does not necessarily indicate the presence of prostate cancer, and conversely, prostate cancer may be present even with a low PSA level. Therefore, individuals should approach prostate health with a comprehensive understanding of the risk factors involved and engage in open communication with healthcare professionals to make well-informed decisions regarding further testing and potential diagnosis.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Constants.grey),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 100,
        child: CustomButton(
          height: 50,
          onTap: () {
            Navigator.pop(context);
          },
          title: "I understand",
        ),
      ),
    ));
  }
}
