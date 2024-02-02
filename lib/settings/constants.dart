import 'dart:convert';

import 'package:cloudinary/cloudinary.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class Constants {
  static String url = "http://api.devbracket.tech/api/v1";
  //"http://api.devbracket.tech/api/v1";
  //https://api.kiasup.com/api/v1

  //COLOUR
  static Color grey = Colors.grey;
  static Color white = Color(0xFFFFFFFF);
  static Color transperent = Colors.transparent;

  static Color black = Colors.black;
  static Color orange = Color(0xFFEA985B);
  static Color primaryBlue = Color(0xFF007BFF);
  static Color lightBlue = Color(0xFF97CDFF);
  static Color teal = Color(0xFF008080);
  static Color purple = Color(0xFF3E64FF);
  static Color darkPurple = Color(0xFF9747FF);
// F7A1A3
  ///STYLE
  static TextStyle title = TextStyle(
    fontSize: 27,
    fontWeight: FontWeight.w600,
  );
  static TextStyle Montserrat = GoogleFonts.montserrat();

  static BoxDecoration boxDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Constants.grey));
  ////
  static String nairaSymbol = "₦";

  static String profile =
      "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png";

  static Widget gap({double width = 0, double height = 0}) {
    return SizedBox(
      height: height,
      width: width,
    );
  }

  static List<String> validStatuses = ['pending', 'accepted', 'declined'];
  static String hashPassword(String password) {
    var bytes = utf8.encode(password); // data being hashed

    var digest = sha1.convert(bytes);
    return digest.toString();
  }

  static String formatTimestamp(DateTime timestamp) {
    final DateFormat formatter = DateFormat('MMMM yyyy, EEEE, \'at\' hh:mm a');
    return formatter.format(timestamp);
  }

  static String formatTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('h:mm a'); // 'a' for AM/PM
    return formatter.format(dateTime);
  }

  static List<String> genders = ["Male", "Female"];

  static String generateUUID() {
    var uuid = Uuid();
    return uuid.v4(); // Generates a version 4 (random) UUID
  }

  static TimeOfDay dateTimeToTimeOfDay(DateTime dateTime) {
    return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
  }

  static String formatTimeOfDay(TimeOfDay time) {
    final hour = time.hour;
    final minute = time.minute;
    final period = hour >= 12 ? 'PM' : 'AM';

    // Format hour in 12-hour format instead of 24-hour
    final formattedHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);

    // Add leading zero to minute if necessary
    final formattedMinute = minute.toString().padLeft(2, '0');

    return '$formattedHour:$formattedMinute $period';
  }

  static DateTime convertTimeOfDayToDateTime(TimeOfDay time, {DateTime? date}) {
    final now = date ?? DateTime.now();
    return DateTime(now.year, now.month, now.day, time.hour, time.minute);
  }

  static String formatDateTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('h:mm a');
    return formatter.format(dateTime);
  }

  static Cloudinary CloudinaryKey = Cloudinary.signedConfig(
    apiKey: "314639493738266",
    apiSecret: "_BBDkH-rSxAxlg58lec-u6Wu-Ek",
    cloudName: "dwwzrtzb8",
  );
}
