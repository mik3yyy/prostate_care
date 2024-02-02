import 'package:flutter/material.dart';
import 'package:prostate_care/global_comonents/custom_button.dart';
import 'package:prostate_care/main_screens/profile/about_us/question.dart';
import 'package:prostate_care/settings/constants.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Text(
            "About ProstateCARE",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          Constants.gap(width: 20),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "The ProstateCARE application represents a sophisticated and invaluable tool designed to empower men with comprehensive knowledge regarding prostate cancer, facilitating informed decision-making and proactive health management. This innovative application not only serves as an informational resource but also incorporates advanced risk assessment functionalities, enabling users to gauge their susceptibility to prostate cancer through meticulously crafted tests. By providing individuals with a nuanced understanding of their risk factors, the application empowers them to make well-informed choices pertaining to their healthcare.\n\nMoreover, the ProstateCARE app goes beyond mere awareness by offering personalized insights into an individual's health status, allowing users to ascertain their current standing in relation to prostate health. Through user-friendly interfaces and sophisticated algorithms, the application ensures that individuals gain a nuanced understanding of their health metrics, fostering a proactive approach to well-being.\n\nA distinctive feature of the ProstateCARE app is its incorporation of reminder functionalities, strategically designed to enhance users' commitment to maintaining a healthy lifestyle. By seamlessly integrating timely prompts and notifications, the application aids users in adhering to crucial health regimens, including regular check-ups, screenings, and other preventive measures. This holistic approach not only fosters a sense of responsibility towards one's health but also contributes to the early detection and management of potential health concerns, such as prostate cancer.\n\nIn essence, the ProstateCARE application emerges as a multifaceted and sophisticated tool that transcends traditional health awareness platforms. Its amalgamation of informational resources, risk assessment tools, and personalized reminders underscores a commitment to advancing men's health by promoting knowledge, awareness, and proactive engagement in preventive healthcare practices.",
            style: TextStyle(fontSize: 14, color: Constants.grey),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 120,
        child: Column(
          children: [
            CustomButton(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuestionScreen(),
                  ),
                );
              },
              title: "Drop a question for us",
            ),
          ],
        ),
      ),
    );
  }
}
