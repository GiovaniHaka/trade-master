import 'dart:developer';

import 'package:ricky_and_morty/services/local_database/data/hive_database_imp.dart';
import 'package:ricky_and_morty/services/local_database/data/local_database.dart';

abstract class GetAllLocalData {
  Future<List<dynamic>> call(String schema);
}

class GetAllLocalDataImp implements GetAllLocalData {
  late LocalDatabase _localDatabase;

  GetAllLocalDataImp([LocalDatabase? localDatabase]) {
    _localDatabase = localDatabase ?? HiveDatabaseImp();
  }

  @override
  Future<List<dynamic>> call(String schema) async {
    try {
      return await _localDatabase.getAll(schema);
    } catch (e) {
      log(e.toString());
      throw Exception;
    }
  }
}
