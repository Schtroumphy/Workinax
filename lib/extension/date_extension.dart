import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:workinax/extension/time_of_day_extension.dart';

var dbDateFormat = DateFormat('dd/MM/yyyy');

extension DateExtension on DateTime {

  String get formatDbDate => dbDateFormat.format(this);

  String get formatShortDate {
    initializeDateFormatting('fr_FR');
    return DateFormat('EE d MMM, y', 'fr_FR')
        .format(DateTime.now())
        .replaceAll('.', '')
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  String get formatDayMonth {
    final DateFormat formatter = DateFormat('dd/MM');
    return formatter.format(this);
  }

  String get formatHoursMinutes {
    final DateFormat formatter = DateFormat('HH:mm');
    return formatter.format(this);
  }
}

extension DateListExtension on List<TimeOfDay?> {
  String get formatRange {
    if (length != 2 || this[0] == null) return 'N/A';

    return '${this[0]!.formatTimeOfDay} - ${this[1]?.formatTimeOfDay ?? 'N/A'}';
  }

  String get formatHoursDiff {
    if (length != 2 || any((e) => e == null)) return 'N/A';

    return timeDifference(this[0]!, this[1]!);
  }
}
