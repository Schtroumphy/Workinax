import 'package:flutter/material.dart';

extension TimeOfDayExtension on TimeOfDay {
  bool isAfter(TimeOfDay time) {
    final minutes1 = hour * 60 + minute;
    final minutes2 = time.hour * 60 + time.minute;

    return minutes1 > minutes2;
  }
}
