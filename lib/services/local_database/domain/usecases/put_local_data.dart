import 'dart:developer';

import 'package:ricky_and_morty/services/local_database/data/hive_database_imp.dart';
import 'package:ricky_and_morty/services/local_database/data/local_database.dart';

abstract class PutLocalData {
  Future<void> call(String schema, {required dynamic key, dynamic value});
}

class PutLocalDataImp implements PutLocalData {
  late LocalDatabase _localDatabase;

  PutLocalDataImp([LocalDatabase? localDatabase]) {
    _localDatabase = localDatabase ?? HiveDatabaseImp();
  }

  @override
  Future<void> call(String schema,
      {required dynamic key, dynamic value}) async {
    try {
      await _localDatabase.put(schema, key: key, value: value);
    } catch (e) {
      log(e.toString());
      throw Exception;
    }
  }
}
