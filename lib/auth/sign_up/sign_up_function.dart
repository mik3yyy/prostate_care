import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prostate_care/global_comonents/custom_messageHandler.dart';
import 'package:prostate_care/main_screens/main_screen.dart';
import 'package:prostate_care/models/user.dart';
import 'package:prostate_care/providers/auth_provider.dart';
import 'package:prostate_care/settings/print.dart';
import 'package:provider/provider.dart';

class SignUpFunction {
//suming your User model is in user.dart

  static Future<void> addUserToFirestore({
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
    required BuildContext context,
    required User user,
  }) async {
    try {
      var authProvider =
          Provider.of<AuthenticationProvider>(context, listen: false);
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore
          .collection('users')
          .doc(user.id.toString())
          .set(user.toMap());
      authProvider.saveUser(user);

      Navigator.pushNamedAndRemoveUntil(
          context, MainScreen.id, (route) => false);
    } catch (e) {
      Print(e.toString());
      MyMessageHandler.showSnackBar(scaffoldKey, "Check your network");
    }
  }

  static Future<bool> doesEmailExist(String email) async {
    final collection = FirebaseFirestore.instance.collection('users');
    final querySnapshot =
        await collection.where('email', isEqualTo: email).limit(1).get();

    return querySnapshot.docs.isNotEmpty;
  }
}
