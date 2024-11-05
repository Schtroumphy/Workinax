import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:workinax/extension/date_extension.dart';
import 'package:workinax/extension/time_of_day_extension.dart';
import 'package:workinax/model/work_clock.dart';

part 'database_helper.g.dart';

@riverpod
Future<List<WorkClock>> getAll(Ref ref) async {
  final service = ref.watch(workClockServiceProvider);
  return service.getAllWorkClock();
}

@riverpod
Future<WorkClock?> getTodayWorkClock(Ref ref) async {
  final service = ref.watch(workClockServiceProvider);
  return service.getWorkClockByDate(DateTime.now());
}

@riverpod
class DatabaseHelper extends _$DatabaseHelper {
  static Database? _database;

  String path = 'workinax.db';

  @override
  FutureOr<Database> build() {
    return database;
  }

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    // If _database is null, initialize it
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
        CREATE TABLE work_clock
        (
          id                       INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          date                     TEXT UNIQUE,
          startWorkTime            TEXT,
          endWorkTime              TEXT DEFAULT NULL,
          firstBreakDuration       INT DEFAULT 0,
          secondBreakDuration      INT DEFAULT 0
        )  
      ''');
      },
    );
  }
}

@Riverpod(keepAlive: true)
WorkClockService workClockService(Ref ref) {
  return WorkClockService(ref);
}

class WorkClockService {
  final Ref ref;

  WorkClockService(this.ref);

  Future<void> insertWorkClock(WorkClock workClock) async {
    final Database db =
        await ref.read(databaseHelperProvider.notifier).database;

    await db.insert(
      WorkClock.tableName,
      workClock.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    ref.invalidateSelf();
  }

  Future<List<WorkClock>> getAllWorkClock() async {
    final Database db =
        await ref.read(databaseHelperProvider.notifier).database;

    final rows = await db.query(WorkClock.tableName);

    return rows.map((row) => WorkClock.fromJson(row)).toList();
  }

  Future<WorkClock> getWorkClockByDate(DateTime date) async {
    final Database db =
        await ref.read(databaseHelperProvider.notifier).database;

    final row = await db.query(
      WorkClock.tableName,
      where: 'date = ?',
      whereArgs: [date.formatDbDate],
      limit: 1,
    );

    return WorkClock.fromJson(row.first);
  }

  void updateWorkClock({required DateTime date, TimeOfDay? start, TimeOfDay? end}) async {
    final Database db = await ref.read(databaseHelperProvider.notifier).database;

    final Map<String, Object?> valuesToUpdate = {
      'startWorkTime' : start?.formatTimeOfDay,
      'endWorkTime' : end?.formatTimeOfDay,
    }..removeWhere((key, value) => value == null || value == '');

    final formattedValues = valuesToUpdate.keys.map((key) => '$key = ?').join(',');

    final sql = 'UPDATE ${WorkClock.tableName} SET $formattedValues WHERE date = ?';

    await db.rawUpdate(sql, [...valuesToUpdate.values, date.formatDbDate]);

    ref.invalidateSelf();
  }
}
