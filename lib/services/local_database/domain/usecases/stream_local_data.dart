import 'dart:developer';

import 'package:ricky_and_morty/services/local_database/data/hive_database_imp.dart';
import 'package:ricky_and_morty/services/local_database/data/local_database.dart';

abstract class StreamLocalData {
  Stream<dynamic> call(String schema, {required dynamic key});
}

class StreamLocalDataImp implements StreamLocalData {
  late LocalDatabase _localDatabase;

  StreamLocalDataImp([LocalDatabase? localDatabase]) {
    _localDatabase = localDatabase ?? HiveDatabaseImp();
  }

  @override
  Stream<dynamic> call(String schema, {required dynamic key}) {
    try {
      return _localDatabase.stream(schema, key);
    } catch (e) {
      log(e.toString());
      throw Exception;
    }
  }
}
