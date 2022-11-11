import 'dart:developer';

import 'package:ricky_and_morty/services/local_database/data/hive_database_imp.dart';
import 'package:ricky_and_morty/services/local_database/data/local_database.dart';

abstract class InitializeLocalDatabase {
  Future<void> call();
}

class InitializeLocalDatabaseImp implements InitializeLocalDatabase {
  late LocalDatabase _localDatabase;

  InitializeLocalDatabaseImp([LocalDatabase? localDatabase]) {
    _localDatabase = localDatabase ?? HiveDatabaseImp();
  }

  @override
  Future<void> call() async {
    try {
      await _localDatabase.initialize();
    } catch (e) {
      log(e.toString());
      throw Exception();
    }
  }
}
