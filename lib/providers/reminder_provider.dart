import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:prostate_care/models/reminder.dart';

class ReminderProvider extends ChangeNotifier {
  List<Reminder> reminders = [];
  int id = 0;

  Future<void> addReminder(Reminder reminder) async {
    reminders.add(reminder);
    var reminderBox = Hive.box('reminderBox');
    await reminderBox.put('reminderKey', reminders);
    await reminderBox.put('idKey', id);

    notifyListeners();
  }

  getReminder() {
    var reminderBox = Hive.box('reminderBox');
    List l = reminderBox.get("reminderKey") ?? [];
    l.forEach((element) {
      reminders.add(element);
    });
    id = reminderBox.get('idKey') ?? 0;
    // notifyListeners();
  }

  Future<void> updateReminder(
      {required int id, required Reminder reminder}) async {
    int index = reminders.indexWhere((element) => element.id == reminder.id);
    reminders[index] = reminder;
    var reminderBox = Hive.box('reminderBox');

    await reminderBox.put('reminderKey', reminders);

    notifyListeners();
  }

  int getId() {
    id = id + 1;
    return id;
  }

  // clearData() async {
  //   var donorBox = Hive.box('userBox');

  //   await donorBox.delete('userKey');
  //   user = null;

  //   notifyListeners();
  // }
}
