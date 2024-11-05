import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:workinax/model/work_clock.dart';

part 'database_helper.g.dart';

@riverpod
Future<List<WorkClock>> getAll(Ref ref) async {
  final service = ref.watch(workClockServiceProvider);
  return service.getAllWorkClock();
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
    final Database db = await ref.read(databaseHelperProvider.notifier).database;

    await db.insert(
      WorkClock.tableName,
      workClock.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    ref.invalidateSelf();
  }

  Future<List<WorkClock>> getAllWorkClock() async {
    final Database db = await ref.read(databaseHelperProvider.notifier).database;

    final rows = await db.query(WorkClock.tableName);

    return rows.map((row) => WorkClock.fromJson(row)).toList();
  }

}
