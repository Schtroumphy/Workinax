import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workinax/extensions/time_of_day_extension.dart';

main() {
  group('isAfter', () {
    test('given time1 < time2 should return false', () {
      const time1 = TimeOfDay(hour: 3, minute: 25);
      const time2 = TimeOfDay(hour: 4, minute: 20);

      final result = time1.isAfter(time2);
      expect(result, false);
    });

    test('given time1 > time2 should return true', () {
      const time1 = TimeOfDay(hour: 12, minute: 15);
      const time2 = TimeOfDay(hour: 4, minute: 20);

      final result = time1.isAfter(time2);
      expect(result, true);
    });
  });
}
