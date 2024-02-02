import 'package:dialog_alert/dialog_alert.dart';
import 'package:flutter/material.dart';
import 'package:prostate_care/auth/login/login_screen.dart';
import 'package:prostate_care/global_comonents/custom_button_tile.dart';
import 'package:prostate_care/main_screens/profile/about_us/about_us.dart';
import 'package:prostate_care/main_screens/profile/edit_profile.dart';
import 'package:prostate_care/main_screens/risk_screen/risk_screen.dart';
import 'package:prostate_care/providers/auth_provider.dart';
import 'package:prostate_care/settings/constants.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var authProvider =
        Provider.of<AuthenticationProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
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
                "What can we do for you today?",
                style: TextStyle(
                  fontSize: 14,
                  color: Constants.grey,
                ),
              )
            ],
          ),
        ),
        actions: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(
              authProvider.user!.image!,
              height: 40,
              width: 40,
              fit: BoxFit.cover,
            ),
          ),
          Constants.gap(width: 40)
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            ButtonTile(
              subTitle: "Change some information",
              title: "Edit my profile",
              traling: Icon(
                Icons.chevron_right,
                size: 30,
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditProfile()));
              },
            ),
            Constants.gap(width: 20),
            ButtonTile(
              subTitle: "Take new Test now ",
              title: "Take Test",
              traling: Icon(
                Icons.chevron_right,
                size: 30,
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RiskScreen()));
              },
            ),
            Constants.gap(width: 20),
            ButtonTile(
              title: "FAQs and About us",
              subTitle: "Frequently Asked Questions",
              traling: Icon(
                Icons.chevron_right,
                size: 30,
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutUs()));
              },
            ),
            Constants.gap(width: 20),
            ButtonTile(
              title: "Log out",
              subTitle: "Log out of ProstrateCARE",
              traling: Icon(
                Icons.chevron_right,
                size: 30,
              ),
              onTap: () async {
                final result = await showDialogAlert(
                  context: context,
                  title: 'Are you sure?',
                  message: 'Do you want to Log Out?',
                  actionButtonTitle: 'Log out',
                  cancelButtonTitle: 'Cancel',
                  actionButtonTextStyle: const TextStyle(
                    color: Colors.red,
                  ),
                  cancelButtonTextStyle: const TextStyle(
                    color: Colors.black,
                  ),
                );
                if (result == ButtonActionType.action) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, LoginScreen.id, (route) => false);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
