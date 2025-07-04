import 'dart:convert';

import 'package:drift/drift.dart';

class ListConverter
    extends TypeConverter<List<Map<String, dynamic>>?, String?> {
  const ListConverter();

  @override
  List<Map<String, dynamic>>? fromSql(String? fromDb) {
    if (fromDb == null) return null;
    return List<Map<String, dynamic>>.from(json.decode(fromDb));
  }

  @override
  String? toSql(List<Map<String, dynamic>>? value) {
    if (value == null) return null;
    return json.encode(value);
  }
}
