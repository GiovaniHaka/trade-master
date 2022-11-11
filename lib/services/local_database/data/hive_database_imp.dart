import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:ricky_and_morty/services/local_database/data/local_database.dart';

class HiveDatabaseImp implements LocalDatabase {
  @override
  Future<void> initialize() async {
    try {
      await Hive.initFlutter();
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  @override
  Future<void> delete(String schema, {required dynamic key}) async {
    try {
      var box = await Hive.openBox(schema);
      await box.delete(key);
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  @override
  Future<List<dynamic>> getAll(String schema) async {
    try {
      var box = await Hive.openBox(schema);

      if (box.isEmpty) {
        return [];
      }

      final data = box.keys.map((key) {
        final value = box.get(key);
        return {key: value};
      }).toList();

      return data;
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  @override
  Future<void> put(String schema, {required dynamic key, value}) async {
    try {
      var box = await Hive.openBox(schema);
      await box.put(key, value);
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  @override
  Stream<dynamic> stream(String schema, dynamic key) async* {
    try {
      var box = await Hive.openBox(schema);
      yield* box.watch(key: key).map((event) {
        if (event.value == null) {
          return null;
        }
        return {event.key: event.value};
      });
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  @override
  Stream<dynamic> onChange(String schema) async* {
    try {
      await Hive.openBox(schema);

      final box = Hive.box(schema).watch();

      yield* box.map((event) {
        if (event.value == null) {
          return null;
        }
        return {event.key: event.value};
      });
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  @override
  Future<dynamic> getSingle(String schema, {required key}) async {
    try {
      var box = await Hive.openBox(schema);

      if (box.isEmpty) {
        return null;
      }

      final value = box.get(key);

      if (value == null) {
        return null;
      }

      return {key: value};
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }
}
