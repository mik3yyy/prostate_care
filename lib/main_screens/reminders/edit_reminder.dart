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

class EditReminderScreen extends StatefulWidget {
  const EditReminderScreen({super.key, required this.reminder});
  final Reminder reminder;

  @override
  State<EditReminderScreen> createState() => _EditReminderScreenState();
}

class _EditReminderScreenState extends State<EditReminderScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? dateTime;
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  bool loading = false;
  int currentIndex = -1;
  @override
  void initState() {
    // TODO: implement initState
    var reminderProvider =
        Provider.of<ReminderProvider>(context, listen: false);

    super.initState();
    _titleController.text = widget.reminder.title;
    _descriptionController.text = widget.reminder.description;
    dateTime = Constants.convertTimeOfDayToDateTime(widget.reminder.time);
    currentIndex = int.parse(widget.reminder.image);
  }

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
                const Text(
                  "Update Reminder",
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
                          currentTime: dateTime,
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
                  try {
                    NotificationFunction.cancelScheduledNotification(
                        widget.reminder.id);
                    NotificationFunction.scheduleDailyNotification(
                      time: Constants.dateTimeToTimeOfDay(dateTime!),
                      id: widget.reminder.id,
                      title: _titleController.text,
                      body: _descriptionController.text,
                    );
                    // print(object)
                    Reminder reminder = Reminder(
                      id: widget.reminder.id,
                      title: _titleController.text,
                      description: _descriptionController.text,
                      image: currentIndex.toString(),
                      time: Constants.dateTimeToTimeOfDay(dateTime!),
                    );
                    await reminderProvider.updateReminder(
                      id: reminder.id,
                      reminder: reminder,
                    );
                    MyMessageHandler.showSnackBar(
                        scaffoldKey, "Reminder updated successfully");
                    Future.delayed(Duration(milliseconds: 500), () {
                      Navigator.pop(context);
                    });
                  } catch (e) {
                    print(e.toString());
                    MyMessageHandler.showSnackBar(
                        scaffoldKey, "Errror adding reminder");
                  }
                  setState(() {
                    loading = false;
                  });
                },
                title: "Update reminder",
              ),
            ),
          ),
        ),
      ),
    );
  }
}
