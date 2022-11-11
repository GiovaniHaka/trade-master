abstract class LocalDatabase {
  Future<void> initialize();
  Stream<dynamic> onChange(String schema);
  Stream<dynamic> stream(String schema,  dynamic key);
  Future<List<dynamic>> getAll(String schema);
  Future<dynamic> getSingle(String schema, {required dynamic key});
  Future<void> put(String schema, {required dynamic key, dynamic value});
  Future<void> delete(String schema, {required dynamic key});
}