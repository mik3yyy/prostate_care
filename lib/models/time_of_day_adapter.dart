import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class TimeOfDayAdapter extends TypeAdapter<TimeOfDay> {
  @override
  final typeId =
      2; // Ensure that this is unique among all the adapters you have

  @override
  TimeOfDay read(BinaryReader reader) {
    final hours = reader.readInt();
    final minutes = reader.readInt();
    return TimeOfDay(hour: hours, minute: minutes);
  }

  @override
  void write(BinaryWriter writer, TimeOfDay obj) {
    writer.writeInt(obj.hour);
    writer.writeInt(obj.minute);
  }
}
