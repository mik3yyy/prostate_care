import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:prostate_care/global_comonents/empty_screen.dart';
import 'package:prostate_care/main_screens/notification_screen/notification_function.dart';
import 'package:prostate_care/providers/notification_provider.dart';
import 'package:prostate_care/settings/hive.dart';
import 'package:prostate_care/settings/notification.dart';
import 'package:provider/provider.dart';

import '../../settings/constants.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var notificationProvider =
        Provider.of<NotificationProvider>(context, listen: false);
    notificationProvider.notifications = HiveFunction.getNotification();
    // notificationProvider.updateNotification(HiveFunction.getNotification());
  }

  @override
  Widget build(BuildContext context) {
    var notificationProvider =
        Provider.of<NotificationProvider>(context, listen: true);
    print(notificationProvider.notifications);
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: double.maxFinite,
        child: notificationProvider.notifications.length != 0
            ? ListView.separated(
                itemCount: notificationProvider.notifications.length,
                separatorBuilder: (context, index) => SizedBox(
                  height: 10,
                ),
                itemBuilder: (context, index) {
                  Map<String, dynamic> notification = notificationProvider
                          .notifications[
                      notificationProvider.notifications.length - 1 - index];

                  return Slidable(
                      // Specify a key if the Slidable is dismissible.
                      key: const ValueKey(0),

                      // The start action pane is the one at the left or the top side.
                      startActionPane: ActionPane(
                        // A motion is a widget used to control how the pane animates.
                        motion: const ScrollMotion(),

                        // A pane can dismiss the Slidable.
                        dismissible: DismissiblePane(onDismissed: () {}),

                        // All actions are defined in the children parameter.
                        children: [
                          // A SlidableAction can have an icon and/or a label.
                          SlidableAction(
                            onPressed: (context) {
                              setState(() {
                                notificationProvider.deleteNotofication(
                                    notificationProvider.notifications.length -
                                        1 -
                                        index);
                              });
                            },
                            backgroundColor: Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                        ],
                      ),

                      // The end action pane is the one at the right or the bottom side.
                      endActionPane: ActionPane(
                        motion: ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              setState(() {
                                notificationProvider.deleteNotofication(
                                    notificationProvider.notifications.length -
                                        1 -
                                        index);
                              });
                            },
                            backgroundColor: Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                        ],
                      ),

                      // The child of the Slidable is what the user sees when the
                      // component is not dragged.
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 25,
                          backgroundColor: Constants.darkPurple,
                          child: Center(
                            child: Text(notification["title"]
                                .toString()[0]
                                .toUpperCase()),
                          ),
                        ),
                        title: Text(
                          notification["title"].toString(),
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(notification["body"].toString()),
                        trailing: Column(
                          children: [
                            Text(
                              NotificationFunctionMain.getTime(
                                  notification["time"]),
                            ),
                          ],
                        ),
                      ));
                },
              )
            : EmptyState(
                image: "assets/images/notifications.png",
                text: "No notifications yet!",
                height: MediaQuery.sizeOf(context).height * 0.8,
                center: true,
              ),
      ),
    );
  }
}
