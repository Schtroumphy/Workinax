import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:workinax/model/work_clock.dart';

part 'database_helper.g.dart';

@riverpod
Future<List<WorkClock>> getAll(Ref ref) async {
  return ref.read(databaseHelperProvider.notifier).getAllWorkClock();
}

@riverpod
class DatabaseHelper extends _$DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    // If _database is null, initialize it
    _database = await initDatabase();
    return _database!;
  }

  @override
  FutureOr<Database> build() {
    return initDatabase();
  }

  Future<Database> initDatabase() async {
    String path = 'workinax.db';
    // Open or create the database at the specified path
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        // Create the tasks table
        await db.execute('''
        CREATE TABLE work_clock
        (
          id                       INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          date                     TEXT,
          startWorkDate            TEXT,
          endWorkDate              TEXT DEFAULT NULL,
          firstBreakDuration       INT DEFAULT 0,
          secondBreakDuration      INT DEFAULT 0
        )  
      ''');
      },
    );
  }

  Future<void> insertWorkClock(WorkClock workClock) async {
    final Database db = await database;

    await db.insert(
      'work_clock',
      workClock.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<WorkClock>> getAllWorkClock() async {
    final Database db = await database;

    final rows = await db.query('work_clock');

    return rows.map((row) => WorkClock.fromJson(row)).toList();
  }
}
