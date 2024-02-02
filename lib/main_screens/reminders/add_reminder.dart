import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:prostate_care/global_comonents/custom_button.dart';
import 'package:prostate_care/global_comonents/custom_messageHandler.dart';
import 'package:prostate_care/global_comonents/custom_textfield.dart';
import 'package:prostate_care/models/reminder.dart';
import 'package:prostate_care/providers/auth_provider.dart';
import 'package:prostate_care/providers/reminder_provider.dart';
import 'package:prostate_care/settings/constants.dart';
import 'package:prostate_care/settings/notification.dart';
import 'package:provider/provider.dart';

class AddReminderScreen extends StatefulWidget {
  const AddReminderScreen({super.key});

  @override
  State<AddReminderScreen> createState() => _AddReminderScreenState();
}

class _AddReminderScreenState extends State<AddReminderScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? dateTime;
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  bool loading = false;
  int currentIndex = -1;
  @override
  Widget build(BuildContext context) {
    var authProvider =
        Provider.of<AuthenticationProvider>(context, listen: true);
    var reminderProvider = Provider.of<ReminderProvider>(context, listen: true);
    return Material(
      child: SafeArea(
        child: ScaffoldMessenger(
          key: scaffoldKey,
          child: Scaffold(
            appBar: AppBar(
              actions: [
                Text(
                  "New",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Constants.gap(width: 20),
              ],
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Details of your reminder",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Constants.gap(height: 20),
                    CustomTextField(
                      controller: _titleController,
                      hintText: "Enter reminder title",
                      maxLength: 10,
                      onChange: () {
                        setState(() {});
                      },
                    ),
                    Constants.gap(height: 20),
                    CustomTextField(
                      controller: _descriptionController,
                      hintText: "Enter short description",
                      maxLength: 15,
                      onChange: () {
                        setState(() {});
                      },
                    ),
                    Constants.gap(height: 20),
                    GestureDetector(
                      onTap: () {
                        DateTime date = DateTime.now();
                        DatePicker.showTimePicker(
                          context,
                          showTitleActions: true,
                          // minTime: date,
                          // maxTime: DateTime(date.year + 1, date.month, date.day),
                          onChanged: (date) {},
                          onConfirm: (date) {
                            setState(() {
                              dateTime = date;
                            });
                          },
                          currentTime: DateTime.now(),
                          locale: LocaleType.en,
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 10),
                        width: MediaQuery.sizeOf(context).width,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: dateTime != null
                                    ? Constants.teal
                                    : Constants.grey.withOpacity(0.3))
                            // color: Color(0xFFEFEFF0),
                            ),
                        child: Row(
                          children: [
                            Text(
                              dateTime == null
                                  ? "Select Time"
                                  : Constants.formatDateTime(
                                      dateTime!), //"${dateTime!.hour}:${dateTime!.minute.toString().length < 2 ? ("0" + dateTime!.minute.toString()) : dateTime!.minute}",
                              style: TextStyle(
                                color: dateTime != null
                                    ? Constants.black
                                    : Constants.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Constants.gap(height: 20),
                    const Text(
                      "Add a tag to your reminder",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Constants.gap(height: 10),
                    Text(
                      "You can click on any of the tags below",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Constants.grey,
                      ),
                    ),
                    Container(
                        height: 100,
                        child: ListView.builder(
                          itemCount: 5,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Opacity(
                              opacity: currentIndex == index ? 1 : 0.4,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    currentIndex = index;
                                  });
                                },
                                child: Container(
                                  width: MediaQuery.sizeOf(context).width * .15,
                                  child: Image.asset(
                                      'assets/images/reminder/${index + 1}.png'),
                                ),
                              ),
                            );
                          },
                        )),
                  ],
                ),
              ),
            ),
            bottomSheet: Container(
              height: 200,
              color: Constants.white,
              child: CustomButton(
                loading: loading,
                enable: _descriptionController.text.isNotEmpty &&
                    _titleController.text.isNotEmpty &&
                    currentIndex != -1 &&
                    dateTime != null,
                onTap: () async {
                  setState(() {
                    loading = true;
                  });
                  int id = reminderProvider.getId();
                  try {
                    NotificationFunction.scheduleDailyNotification(
                      time: Constants.dateTimeToTimeOfDay(dateTime!),
                      id: id,
                      title: _titleController.text,
                      body: _descriptionController.text,
                    );
                    // print(object)
                    Reminder reminder = Reminder(
                        id: id,
                        title: _titleController.text,
                        description: _descriptionController.text,
                        image: currentIndex.toString(),
                        time: Constants.dateTimeToTimeOfDay(dateTime!));
                    await reminderProvider.addReminder(reminder);
                    MyMessageHandler.showSnackBar(
                        scaffoldKey, "Reminder added successfully");
                    Future.delayed(Duration(milliseconds: 500), () {
                      Navigator.pop(context);
                    });
                  } catch (e) {
                    MyMessageHandler.showSnackBar(
                        scaffoldKey, "Errror adding reminder");
                  }
                  setState(() {
                    loading = false;
                  });
                },
                title: "Add new reminder",
              ),
            ),
          ),
        ),
      ),
    );
  }
}
