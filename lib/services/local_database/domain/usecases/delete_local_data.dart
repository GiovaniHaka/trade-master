import 'dart:developer';

import 'package:ricky_and_morty/services/local_database/data/hive_database_imp.dart';
import 'package:ricky_and_morty/services/local_database/data/local_database.dart';

abstract class DeleteLocalData {
  Future<void> call(String schema, {required dynamic key});
}

class DeleteLocalDataImp implements DeleteLocalData {
  late LocalDatabase _localDatabase;

  DeleteLocalDataImp([LocalDatabase? localDatabase]) {
    _localDatabase = localDatabase ?? HiveDatabaseImp();
  }

  @override
  Future<void> call(String schema, {required dynamic key}) async {
    try {
      await _localDatabase.delete(schema, key: key);
    } catch (e) {
      log(e.toString());
      throw Exception;
    }
  }
}