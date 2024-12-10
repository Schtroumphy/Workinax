import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:workinax/data/dao/work_break_dao.dart';
import 'package:workinax/data/database_notifier.dart';
import 'package:workinax/time_entry/data/model/work_break.dart';

import '../../testing/test.dart';

void main() {
  late ProviderContainer container;
  late MockDatabase mockDatabase;
  late MockDatabaseNotifier mockDatabaseNotifier;

  setUp(() {
    sqfliteInit();
    mockDatabase = MockDatabase();
    mockDatabaseNotifier = MockDatabaseNotifier();

    container = ProviderContainer(overrides: [
      databaseNotifierProvider.overrideWith(() => mockDatabaseNotifier),
    ]);

    when(() => mockDatabaseNotifier.database).thenAnswer((_) async => mockDatabase);
  });

  group('WorkBreakDao', () {
    test('should correctly access database from provider', () async {
      final workBreakDao = container.read(workBreakDaoProvider);

      final db = await workBreakDao.database();
      expect(db, equals(mockDatabase));
    });

    test('fromJson should correctly deserialize JSON to WorkBreak', () {
      final json = {
        'id': 1,
        'startTime': '2023-11-14T10:00:00.000Z',
        'endTime': '2023-11-14T11:00:00.000Z',
      };

      final workBreak = container.read(workBreakDaoProvider).fromJson(json);
      expect(workBreak, isA<WorkBreak>());
      expect(workBreak.id, equals(1));
      expect(workBreak.startTime.toIso8601String(), equals(json['startTime']));
      expect(workBreak.endTime?.toIso8601String(), equals(json['endTime']));
    });

    test('toJson should correctly serialize WorkBreak to JSON', () {
      final workBreak = WorkBreak(
        id: 1,
        startTime: DateTime.parse('2023-11-14T10:00:00.000Z'),
        endTime: DateTime.parse('2023-11-14T11:00:00.000Z'),
      );

      final json = container.read(workBreakDaoProvider).toJson(workBreak);
      expect(json, isA<Map<String, dynamic>>());
      expect(json['id'], equals(1));
      expect(json['startTime'], equals('2023-11-14T10:00:00.000Z'));
      expect(json['endTime'], equals('2023-11-14T11:00:00.000Z'));
    });
  });
}
