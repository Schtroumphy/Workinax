import 'package:sqflite/sqflite.dart';
import 'package:workinax/data/app_entity.dart';

typedef Json = Map<String, Object?>;

/// Base DAO operations not abstraction pattern to easily switch of data source
abstract class DAO<T extends AppEntity> {
  const DAO(this.tableName);

  final String tableName;

  Future<Database> database();

  Json toJson(T object);

  T fromJson(Json object);

  Future<U> withDatabase<U>(Future<U> Function(Database) callback) async {
    return database().then(callback);
  }

  Future<T?> queryFirstItem(
      {String? where, List<String> whereArgs = const []}) async {
    final rows = await withDatabase(
      (db) => db.query(
        tableName,
        limit: 1,
      ),
    );

    return rows.isEmpty ? null : fromJson(rows.first);
  }

  Future<List<T>> queryItems(
      {String? where, List<Object> whereArgs = const []}) async {
    final rows = await withDatabase(
      (db) => db.query(
        tableName,
        where: where,
        whereArgs: whereArgs,
      ),
    );

    return rows.map((e) => fromJson(e)).toList();
  }

  Future<int> save(T object) async {
    return withDatabase(
      (db) => db.insert(
        tableName,
        toJson(object),
        conflictAlgorithm: ConflictAlgorithm.replace,
      ),
    );
  }

  Future<T?> getById(int id) async {
    final rows = await withDatabase(
      (db) => db.query(
        tableName,
        where: 'id = ?',
        whereArgs: [id],
      ),
    );

    return rows.isEmpty ? null : fromJson(rows.first);
  }

  Future<List<T>> getAll({
    String? where,
    List<String> whereArgs = const [],
  }) async {
    return queryItems(
      where: where,
      whereArgs: whereArgs,
    );
  }

  void deleteById(int id) async {
    await withDatabase(
      (db) => db.delete(
        tableName,
        where: 'id = ?',
        whereArgs: [id],
      ),
    );
  }
}
