import 'package:flutter/material.dart';
import 'package:prostate_care/Firebase/storage.dart';
import 'package:prostate_care/global_comonents/custom_messageHandler.dart';
import 'package:prostate_care/models/user.dart';
import 'package:prostate_care/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class MainFunction {
  static Reload({
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
        if (user.password == (password)) {
          authProvider.saveUser(user);
        } else {
          MyMessageHandler.showSnackBar(scaffoldKey, "Wrong email or password");
        }
      } else {
        MyMessageHandler.showSnackBar(scaffoldKey, "Wrong email or password");
      }
    } catch (e) {
      MyMessageHandler.showSnackBar(scaffoldKey, "Check your network");
    }
  }
}
