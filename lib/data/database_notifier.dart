import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';

part 'database_notifier.g.dart';

@riverpod
class DatabaseNotifier extends _$DatabaseNotifier {
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
          DROP TABLE IF EXISTS time_entry 
        ''');

        await db.execute('''
        CREATE TABLE time_entry
        (
          id                       INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          date                     TEXT UNIQUE,
          startTime                TEXT,
          endTime                  TEXT DEFAULT NULL
        );
        ''');

        await db.execute('''
          DROP TABLE IF EXISTS work_break
        ''');

        await db.execute('''
        CREATE TABLE work_break
        (
          id                       INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          startTime                TEXT,
          endTime                  TEXT DEFAULT NULL,
          timeEntryId              INT
        )  
        ''');
      },
    );
  }
}
