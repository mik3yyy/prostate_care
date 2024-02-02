import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:prostate_care/models/user.dart';

class AuthenticationProvider extends ChangeNotifier {
  User? user;

  saveUser(User d) async {
    user = d;
    var donorBox = Hive.box('userBox');
    // var box = await Hive.openBox<Donor>('donorBox');
    await donorBox.put('userKey', d);

    // var box2 = await Hive.openBox<BloodBank>('bankBox');

    notifyListeners();
  }

  clearData() async {
    var donorBox = Hive.box('userBox');

    await donorBox.delete('userKey');
    user = null;

    notifyListeners();
  }
}
