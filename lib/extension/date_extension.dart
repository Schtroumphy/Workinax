import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:workinax/core/constants/app_date_format.dart';
import 'package:workinax/extension/string_extension.dart';
import 'package:workinax/extension/time_of_day_extension.dart';

extension DateExtension on DateTime {

  String get formatDbDate => AppDateFormat.dbDateFormat.format(this);

  String get formatShortDate {
    initializeDateFormatting(AppDateFormat.locale);
    return AppDateFormat.mediumDateFormat
        .format(AppDateFormat.now)
        .replaceAll('.', '')
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  String get formatDayMonth => AppDateFormat.shortDayMonth.format(this);

  String get formatHoursMinutes => AppDateFormat.shortHourMinute.format(this);

}

extension DateListExtension on List<TimeOfDay?> {
  String get formatRange {
    if (length != 2 || this[0] == null) return 'N/A';

    return '${this[0]!.formatTimeOfDay} - ${this[1]?.formatTimeOfDay.orNA}';
  }

  String get formatHoursDiff {
    if (length != 2 || any((e) => e == null)) return 'N/A';

    return timeDifference(this[0]!, this[1]!);
  }
}
