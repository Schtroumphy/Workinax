import 'package:flutter_test/flutter_test.dart';
import 'package:workinax/extensions/duration_extension.dart';

main() {
  group('formatDuration', () {
    test('given null duration should return Ø', () {
      const Duration? duration = null;

      final result = duration.formatDuration;
      expect(result, 'Ø');
    });

    test('given empty duration should return Ø', () {
      const duration = Duration.zero;

      final result = duration.formatDuration;
      expect(result, 'Ø');
    });

    test('given only seconds should return XXs', () {
      const duration = Duration(seconds: 30);

      final result = duration.formatDuration;
      expect(result, '30s');
    });

    test('given only minutes should return XXm', () {
      const duration = Duration(minutes: 20);

      final result = duration.formatDuration;
      expect(result, '20m');
    });

    test('given only hours should return XXh', () {
      const duration = Duration(hours: 3);

      final result = duration.formatDuration;
      expect(result, '3h');
    });

    test('given hours & minutes should return XXh XXm', () {
      const duration = Duration(hours: 3, minutes: 35);

      final result = duration.formatDuration;
      expect(result, '3h 35m');
    });

    test('given hours & seconds should return XXh XXs', () {
      const duration = Duration(hours: 3, seconds: 15);

      final result = duration.formatDuration;
      expect(result, '3h 15s');
    });

    test('given minutes & seconds should return XXm XXs', () {
      const duration = Duration(minutes: 33, seconds: 15);

      final result = duration.formatDuration;
      expect(result, '33m 15s');
    });
  });

  group('formatClockDuration', () {
    test('given empty duration should return N/A', () {
      const duration = Duration.zero;

      final result = duration.formatClockDuration;
      expect(result, 'N/A');
    });

    test('given empty duration should return N/A', () {
      const Duration? duration = null;

      final result = duration.formatClockDuration;
      expect(result, 'N/A');
    });

    test('given only seconds duration should return 00:00:xx', () {
      const duration = Duration(seconds: 34);

      final result = duration.formatClockDuration;
      expect(result, '00:00:34');
    });

    test('given only minutes duration should return 00:xx:00', () {
      const duration = Duration(minutes: 25);

      final result = duration.formatClockDuration;
      expect(result, '00:25:00');
    });

    test('given only hours duration should return xx:00:00', () {
      const duration = Duration(hours: 12);

      final result = duration.formatClockDuration;
      expect(result, '12:00:00');
    });

    test('given only hours & minutes duration should return xx:xx:00', () {
      const duration = Duration(hours: 12, minutes: 45);

      final result = duration.formatClockDuration;
      expect(result, '12:45:00');
    });

    test('given only hours & seconds duration should return xx:00:xx', () {
      const duration = Duration(hours: 12, seconds: 6);

      final result = duration.formatClockDuration;
      expect(result, '12:00:06');
    });

    test('given only minutes & seconds duration should return 00:xx:xx', () {
      const duration = Duration(minutes: 52, seconds: 6);

      final result = duration.formatClockDuration;
      expect(result, '00:52:06');
    });
  });

  group('orZero', () {
    test('given null duration should zero', () {
      const Duration? duration = null;

      final result = duration.orZero;
      expect(result, Duration.zero);
    });

    test('given not null duration should return duration', () {
      const duration = Duration(hours: 5);

      final result = duration.orZero;
      expect(result, duration);
    });
  });
}
