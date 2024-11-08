import 'package:intl/intl.dart';

class AppDateFormat {
  AppDateFormat._();

  static final now = DateTime.now();

  static const locale = 'fr_FR';

  static final shortDayMonth = DateFormat('dd/MM');
  static final shortDayNumber = DateFormat('EE d');
  static final shortHourMinute = DateFormat('HH:mm');
  static final dbDateFormat = DateFormat('dd/MM/yyyy');
  static final dbShortDateFormat = DateFormat('yyyy-MM-dd');
  static final mediumDateFormat = DateFormat('EE d MMM, y', locale);
}
