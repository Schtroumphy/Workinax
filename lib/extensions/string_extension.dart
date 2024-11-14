import 'package:flutter/material.dart';

extension StringTimeExtension on String {

  TimeOfDay get toTimeOfDay {
    final parts = split(':');
    if (parts.length != 2) {
      throw const FormatException('Format invalide, doit être HH:mm');
    }

    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);

    if (hour < 0 || hour > 23) throw const FormatException('Heure invalide');
    if (minute < 0 || minute > 59) {
      throw const FormatException('Minutes invalides');
    }

    return TimeOfDay(hour: hour, minute: minute);
  }

}

extension StringNullableExtension on String? {

  String get orNA => this ?? 'N/A';

}