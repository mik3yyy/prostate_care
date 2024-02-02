import 'package:flutter/widgets.dart';
import 'package:prostate_care/providers/notification_provider.dart';
import 'package:provider/provider.dart';

import 'package:intl/intl.dart';

class NotificationFunctionMain {
  void deleteNotification(BuildContext context, int index) {
    var notificationProvider =
        Provider.of<NotificationProvider>(context, listen: false);

    notificationProvider.deleteNotofication(index);
  }

  static String getTime(DateTime date) {
    DateTime today = DateTime.now();
    if (date.isAfter(DateTime(today.year, today.month, today.day))) {
      return DateFormat("hh:mma").format(date);
    } else if (date.isAfter(today.subtract(const Duration(days: 1)))) {
      return "Yesterday";
    } else {
      return DateFormat("dd MMMM yyyy").format(date);
    }
  }
}
