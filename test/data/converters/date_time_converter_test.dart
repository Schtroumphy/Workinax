import 'package:flutter_test/flutter_test.dart';
import 'package:workinax/core/constants/app_date_format.dart';
import 'package:workinax/data/converters/date_time_converter.dart';

main() {
  group('DateTimeConverter', () {
    const converter = DateTimeConverter();

    group('fromJson', () {
      test('given valid JSON should return DateTime object', () {
        const json = '2023-11-14T10:00:00.000Z';
        final result = converter.fromJson(json);

        expect(result, isA<DateTime>());
        expect(result.toIso8601String(), json);
      });

      test('given invalid JSON should throw FormatException', () {
        const invalidJson = 'invalid-date';

        expect(
          () => converter.fromJson(invalidJson),
          throwsA(isA<FormatException>()),
        );
      });

      test('given empty JSON should throw FormatException', () {
        const emptyJson = '';

        expect(
          () => converter.fromJson(emptyJson),
          throwsA(isA<FormatException>()),
        );
      });
    });

    group('toJson', () {
      test('given DateTime object should return ISO8601 string', () {
        final dateTime = DateTime.parse('2023-11-14T10:00:00.000Z');
        final result = converter.toJson(dateTime);

        expect(result, '2023-11-14T10:00:00.000Z');
      });
    });
  });

  group('SimpleDateTimeConverter', () {
    const converter = SimpleDateTimeConverter();

    group('fromJson', () {
      test('given valid JSON should return DateTime object', () {
        const json = '2023-11-14T10:00:00.000Z';
        final result = converter.fromJson(json);

        expect(result, isA<DateTime>());
        expect(result.toIso8601String(), json);
      });

      test('given invalid JSON should throw FormatException', () {
        const invalidJson = 'invalid-date';

        expect(
          () => converter.fromJson(invalidJson),
          throwsA(isA<FormatException>()),
        );
      });

      test('given empty JSON should throw FormatException', () {
        const emptyJson = '';

        expect(
          () => converter.fromJson(emptyJson),
          throwsA(isA<FormatException>()),
        );
      });
    });

    group('toJson', () {
      test('given DateTime object should return formatted string', () {
        final dateTime = DateTime(2023, 11, 14, 10, 0, 0);
        final expectedFormat = AppDateFormat.dbShortDateFormat;

        final result = converter.toJson(dateTime);

        expect(result, expectedFormat.format(dateTime));
      });
    });
  });
}
