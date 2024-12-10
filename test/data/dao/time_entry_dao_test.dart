import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod/riverpod.dart';
import 'package:workinax/data/dao/time_entry_dao.dart';
import 'package:workinax/data/database_notifier.dart';
import 'package:workinax/time_entry/data/model/time_entry.dart';

import '../../testing/test.dart';

void main() {
  late ProviderContainer container;
  late MockDatabase mockDatabase;
  late MockDatabaseNotifier mockDatabaseNotifier;

  setUp(() {
    mockDatabase = MockDatabase();
    mockDatabaseNotifier = MockDatabaseNotifier();

    when(() => mockDatabaseNotifier.database).thenAnswer((_) async => mockDatabase);

    container = ProviderContainer(overrides: [
      databaseNotifierProvider.overrideWith(() => mockDatabaseNotifier),
    ]);
  });

  group('TimeEntryDao', () {
    test('should correctly access database from provider', () async {
      final timeEntryDao = container.read(timeEntryDaoProvider);

      final db = await timeEntryDao.database();
      expect(db, equals(mockDatabase));
    });

    test('should correctly call fromJson to create TimeEntry from json', () {
      final timeEntryJson = {
        'id': 1,
        'startTime': '2024-11-01T12:00:00',
        'endTime': '2024-11-01T14:00:00',
      };
      final timeEntryDao = container.read(timeEntryDaoProvider);

      final timeEntry = timeEntryDao.fromJson(timeEntryJson);

      expect(timeEntry, isA<TimeEntry>());
      expect(timeEntry.id, equals(1));
      expect(timeEntry.date,DateTime.parse('2024-11-01'));
      expect(timeEntry.startTime,DateTime(2024, 11, 1, 12));
      expect(timeEntry.endTime,DateTime(2024, 11, 1, 14));
    });

    test('should correctly call toJson on TimeEntry to get json', () {
      final timeEntry = TimeEntry(
        id: 1,
        startTime: DateTime.parse('2024-11-01T12:00:00'),
        endTime: DateTime.parse('2024-11-01T14:00:00'),
      );

      final timeEntryDao = container.read(timeEntryDaoProvider);

      final json = timeEntryDao.toJson(timeEntry);

      expect(
          json,
          equals({
            'id': 1,
            'date': '2024-11-01',
            'startTime': '2024-11-01T12:00:00.000',
            'endTime': '2024-11-01T14:00:00.000',
          }));
    });
  });

  group('withDatabase', () {
    test('should called callback function', () async {
      final timeEntryDao = container.read(timeEntryDaoProvider);
      fun(_) => Future.value(3);

      timeEntryDao.withDatabase(fun);

      verify(() => fun).called(1);
    });
  });
}
