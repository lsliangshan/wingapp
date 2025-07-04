import 'dart:convert';

import 'package:drift/drift.dart';

class MapConverter extends TypeConverter<Map<String, dynamic>?, String?> {
  const MapConverter();

  @override
  Map<String, dynamic>? fromSql(String? fromDb) {
    if (fromDb == null) return null;
    return Map<String, dynamic>.from(json.decode(fromDb));
  }

  @override
  String? toSql(Map<String, dynamic>? value) {
    if (value == null) return null;
    return json.encode(value);
  }
}
