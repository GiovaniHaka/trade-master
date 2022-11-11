import 'dart:developer';

import 'package:ricky_and_morty/services/local_database/data/hive_database_imp.dart';
import 'package:ricky_and_morty/services/local_database/data/local_database.dart';

abstract class OnChangeLocalData {
  Stream<dynamic> call(String schema);
}

class OnChangeLocalDataImp implements OnChangeLocalData {
  late LocalDatabase _localDatabase;

  OnChangeLocalDataImp([LocalDatabase? localDatabase]) {
    _localDatabase = localDatabase ?? HiveDatabaseImp();
  }

  @override
  Stream<dynamic> call(String schema) {
    try {
      return _localDatabase.onChange(schema);
    } catch (e) {
      log(e.toString());
      throw Exception;
    }
  }
}
