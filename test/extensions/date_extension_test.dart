import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workinax/extensions/date_extension.dart';

main() {
  group('', () {
    // given
    final date = DateTime(2024, 11, 14, 08, 20);

    group('Format date', () {
      test('formatDbShortDate should format date like yyyy-MM-dd', () {
        final result = date.formatDbShortDate;
        expect(result, '2024-11-14');
      });

      test('formatDayNumber should format date like EE d', () {
        final result = date.formatDayNumber;
        expect(result, 'Thu 14');
      });

      test('formatHoursMinutes should format date like HH:mm', () {
        final result = date.formatHoursMinutes;
        expect(result, '08:20');
      });

      test('formatShortDate should format date like EE d MMM, y in French', () {
        final result = date.formatFrShortDate;
        expect(result, 'Jeu 14 Nov, 2024');
      });
    });

    test('toTimeOfDay', () {
      final result = date.toTimeOfDay;
      expect(result, const TimeOfDay(hour: 08, minute: 20));
    });
  });
  group('DateListExtension', () {
    group('formatRange', () {
      test(
        'given list of 2 dates should return date1 - date2 '
        'formatted with only hours and minutes',
        () {
          final date1 = DateTime(2024, 11, 14, 08, 20);
          final date2 = DateTime(2024, 11, 15, 08, 30);

          final result = [date1, date2].formatRange;
          expect(result, '08:20 - 08:30');
        },
      );

      test('given list of 1 date should return N/A', () {
        final date1 = DateTime(2024, 11, 14, 08, 20);

        final result = [date1].formatRange;
        expect(result, 'N/A');
      });

      test('given list of 2 dates with first one null should return N/A', () {
        const DateTime? date1 = null;
        final date2 = DateTime(2024, 11, 14, 08, 20);

        final result = [date1, date2].formatRange;
        expect(result, 'N/A');
      });

      test('given list of 2 dates with second one null should return N/A', () {
        final date1 = DateTime(2024, 11, 14, 08, 20);
        const DateTime? date2 = null;

        final result = [date1, date2].formatRange;
        expect(result, 'N/A');
      });

      test('given empty list should return N/A', () {
        final result = <DateTime>[].formatRange;
        expect(result, 'N/A');
      });
    });
  });
}
