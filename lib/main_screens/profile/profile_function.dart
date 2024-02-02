import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prostate_care/global_comonents/custom_messageHandler.dart';
import 'package:prostate_care/models/user.dart';
import 'package:prostate_care/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class ProfileFunction {
  static Future<void> updateUserDocument({
    required User user,
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
    required BuildContext context,
  }) async {
    var authProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      await firestore.collection('users').doc(user.id).update(user.toMap());
      authProvider.saveUser(user);
      MyMessageHandler.showSnackBar(scaffoldKey, "Profile Edited Successfully");
      Future.delayed(Duration(milliseconds: 500), () {
        Navigator.pop(context);
      });
    } catch (e) {
      MyMessageHandler.showSnackBar(scaffoldKey, "Error Editing profile");
      // Handle errors, e.g., user not found, no internet connection, etc.
      print(e); // Consider a better error handling approach
    }
  }
}
