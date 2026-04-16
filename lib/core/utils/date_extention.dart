import 'package:flutter/material.dart';

extension DateExtention on DateTime{

  DateTime get dateOnly{
    return DateTime(year,month,day);
  }
}

extension TimeOfDayExtension on TimeOfDay {
  String get time {
    final hour12 = hour % 12 == 0 ? 12 : hour % 12;
    final minutePadded = minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? "PM" : "AM";

    return "$hour12:$minutePadded $period";
  }
}