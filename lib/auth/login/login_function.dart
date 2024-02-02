import 'package:flutter/material.dart';
import 'package:prostate_care/Firebase/storage.dart';
import 'package:prostate_care/global_comonents/custom_messageHandler.dart';
import 'package:prostate_care/main_screens/main_screen.dart';
import 'package:prostate_care/models/user.dart';
import 'package:prostate_care/providers/auth_provider.dart';
import 'package:prostate_care/settings/constants.dart';
import 'package:prostate_care/settings/print.dart';
import 'package:provider/provider.dart';

class LoginFunction {
  static login({
    required String email,
    required String password,
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
    required BuildContext context,
  }) async {
    var authProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    try {
      Map<String, dynamic> userDoc = await FirebaseStorageApi.userDoc(
          email: email, password: password, collection: 'users');
      if (userDoc.isNotEmpty) {
        User user = User.fromMap(userDoc);
        Print(user.toString());
        if (user.password == Constants.hashPassword(password)) {
          authProvider.saveUser(user);
          Navigator.pushNamedAndRemoveUntil(
              context, MainScreen.id, (route) => false);
        } else {
          MyMessageHandler.showSnackBar(scaffoldKey, "Wrong email or password");
        }
      } else {
        MyMessageHandler.showSnackBar(scaffoldKey, "Wrong email or password");
      }
    } catch (e) {
      Print(e.toString());
      MyMessageHandler.showSnackBar(scaffoldKey, "Check your network");
    }
  }
}
