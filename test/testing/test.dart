import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:workinax/data/database_notifier.dart';

void sqfliteInit() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
}

// Mocks
// Source for riverpod generator : https://github.com/rrousselGit/riverpod/discussions/2514
class MockDatabase extends Database with Mock {}

class MockDatabaseNotifier extends AutoDisposeAsyncNotifier<Database> with Mock implements DatabaseNotifier {}
