import 'package:flutter/material.dart';
import 'package:prostate_care/main_screens/reminders/add_reminder.dart';
import 'package:prostate_care/main_screens/reminders/edit_reminder.dart';
import 'package:prostate_care/models/reminder.dart';
import 'package:prostate_care/providers/auth_provider.dart';
import 'package:prostate_care/providers/reminder_provider.dart';
import 'package:prostate_care/settings/constants.dart';
import 'package:provider/provider.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({super.key});

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  @override
  Widget build(BuildContext context) {
    var authProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    var reminderProvider = Provider.of<ReminderProvider>(context, listen: true);
    return SafeArea(
      child: Scaffold(
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
                  "Your reminders are here!",
                  style: TextStyle(
                    fontSize: 14,
                    color: Constants.grey,
                  ),
                )
              ],
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddReminderScreen()));
              },
              icon: Icon(
                Icons.add,
                color: Constants.teal,
              ),
            ),
            Constants.gap(width: 16)
          ],
        ),
        body: Container(
          margin: EdgeInsets.only(top: 15),
          padding: EdgeInsets.symmetric(horizontal: 16),
          height: double.infinity,
          child: ListView.builder(
            itemCount: reminderProvider.reminders.length,
            itemBuilder: (context, index) {
              Reminder reminder = reminderProvider.reminders[index];
              return ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              EditReminderScreen(reminder: reminder)));
                },
                leading: Image.asset(
                    'assets/images/reminder/${int.parse(reminder.image) + 1}.png'),
                title: Text(
                  reminder.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  reminder.description,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                trailing: Text(
                  Constants.formatTimeOfDay(reminder.time),
                  style: TextStyle(
                    color: Constants.teal,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
