import 'dart:developer';

import 'package:ricky_and_morty/services/local_database/data/hive_database_imp.dart';
import 'package:ricky_and_morty/services/local_database/data/local_database.dart';

abstract class GetSingleLocalData {
  Future<dynamic> call(String schema, {required int key});
}

class GetSingleLocalDataImp implements GetSingleLocalData {
  late LocalDatabase _localDatabase;

  GetSingleLocalDataImp([LocalDatabase? localDatabase]) {
    _localDatabase = localDatabase ?? HiveDatabaseImp();
  }

  @override
  Future<dynamic> call(String schema, {required int key}) async {
    try {
      return await _localDatabase.getSingle(schema, key: key);
    } catch (e) {
      log(e.toString());
      throw Exception;
    }
  }
}
