import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:workinax/data/app_entity.dart';
import 'package:workinax/data/dao/dao.dart';

import '../../testing/test.dart';

class MockEntity extends AppEntity{}

class MockDao extends DAO<MockEntity>{
  MockDao() : super('mock_dao');

  @override
  Future<Database> database() => Future.value(MockDatabase());

  @override
  MockEntity fromJson(Json object) => MockEntity();

  @override
  Json toJson(MockEntity object) => {};
}

class MockDao2 extends Mock implements DAO<MockEntity>{}

main(){

  group('withDatabase', (){

    test('should call the given callback', (){
      final mockDao = MockDao2();
      fun(_) => Future.value(3);

      mockDao.withDatabase(fun);
      
      verify(() => fun).called(1);
    });
  });
}