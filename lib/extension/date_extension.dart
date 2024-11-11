import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:workinax/core/constants/app_date_format.dart';
import 'package:workinax/extension/string_extension.dart';

extension DateExtension on DateTime {
  String get formatDbDate => AppDateFormat.dbDateFormat.format(this);

  String get formatDbShortDate => AppDateFormat.dbShortDateFormat.format(this);

  String get formatShortDate {
    initializeDateFormatting(AppDateFormat.locale);
    return AppDateFormat.mediumDateFormat
        .format(this)
        .replaceAll('.', '')
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  String get formatDayMonth => AppDateFormat.shortDayMonth.format(this);

  String get formatDayNumber => AppDateFormat.shortDayNumber.format(this);

  String get formatHoursMinutes => AppDateFormat.shortHourMinute.format(this);

  TimeOfDay get toTimeOfDay => TimeOfDay(hour: hour, minute: minute);
}

extension DateListExtension on List<DateTime?> {
  String get formatRange {
    if (length != 2 || this[0] == null) return 'N/A';

    return '${this[0]!.formatHoursMinutes} - ${this[1]?.formatHoursMinutes.orNA}';
  }
}
