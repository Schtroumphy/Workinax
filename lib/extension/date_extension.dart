import 'package:intl/intl.dart';

extension DateExtension on DateTime {

  String get formatDayMonth {
    final DateFormat formatter = DateFormat('dd/MM');
    return formatter.format(this);
  }

  String get formatHoursMinutes {
    final DateFormat formatter = DateFormat('HH:mm');
    return formatter.format(this);
  }
}

extension DateListExtension on List<DateTime?> {

  String get formatRange {
    if(length != 2 || this[0] == null) return 'N/A';

    return '${this[0]!.formatHoursMinutes} - ${this[1]?.formatHoursMinutes ?? 'N/A'}';
  }

  String get formatHoursDiff {
    if(length != 2 || any((e) => e == null)) return 'N/A';

    final diff = this[0]!.difference(this[1]!);
    return '${diff.inHours}:${diff.inMinutes}';
  }

}