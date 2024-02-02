import 'package:flutter/material.dart';
import 'package:prostate_care/settings/hive.dart';

class NotificationProvider extends ChangeNotifier {
  // int main = HiveFunction.getMain();
  List<Map<String, dynamic>> notifications = HiveFunction.getNotification();
  bool showBadge = HiveFunction.showBanner();

  void updateNotification(List<Map<String, dynamic>> notifications_1) {
    notifications = notifications_1;
    notifyListeners();
  }

  void updateBanner(bool show) {
    HiveFunction.updateBanner(show);
    notifyListeners();
  }

  // void addAddress(Map<String, String> notification) {
  //   notifications.add(notification);
  //   HiveFunction.updateAddress(notification);

  //   notifyListeners();
  // }

  void deleteNotofication(int index) {
    notifications.removeAt(index);
    HiveFunction.updateNotificationList(notifications);
    notifyListeners();
  }

  void clearNotification() {
    notifications = [];
    HiveFunction.updateNotificationList(notifications);

    notifyListeners();
  }
}
