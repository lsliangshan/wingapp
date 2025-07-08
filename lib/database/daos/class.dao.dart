import 'package:drift/drift.dart';
import 'package:wingapp/database/database.dart';
import 'package:wingapp/database/tables.dart';

part 'class.dao.g.dart';

@DriftAccessor(
    tables: [Classes], queries: {'countAll': 'SELECT COUNT(*) FROM classes;'})
class ClassDao extends DatabaseAccessor<AppDatabase> with _$ClassDaoMixin {
  // 构造方法是必需的，这样主数据库可以创建这个对象的实例。
  // ignore: use_super_parameters
  ClassDao(AppDatabase db) : super(db);

  Future<int> createOrUpdateClass({
    required String id,
    required String name,
    String? icon,
    String? teacherId,
    String? teacherName,
    String? teacherEnName,
    String? teacherUnionId,
    String? robotCode,
    String? openConversationId,
    String? chatId,
    String? link,
    String? assistant,
  }) {
    return into(classes).insertOnConflictUpdate(ClassesCompanion(
      id: Value(id),
      name: Value(name),
      icon: Value(icon ?? ''),
      teacherId: Value(teacherId ?? ''),
      teacherName: Value(teacherName ?? ''),
      teacherEnName: Value(teacherEnName ?? ''),
      teacherUnionId: Value(teacherUnionId ?? ''),
      robotCode: Value(robotCode ?? ''),
      openConversationId: Value(openConversationId ?? ''),
      chatId: Value(chatId ?? ''),
      link: Value(link ?? ''),
      assistant: Value(assistant ?? ''),
    ));
  }

  Future<int> updateClass({
    required String id,
    String? name,
    String? icon,
    String? teacherId,
    String? teacherName,
    String? teacherEnName,
    String? teacherUnionId,
    String? robotCode,
    String? openConversationId,
    String? chatId,
    String? link,
    String? assistant,
  }) {
    ClassesCompanion companion = const ClassesCompanion();
    if (name != null) {
      companion = companion.copyWith(name: Value(name));
    }
    if (icon != null) {
      companion = companion.copyWith(icon: Value(icon));
    }
    if (teacherId != null) {
      companion = companion.copyWith(teacherId: Value(teacherId));
    }
    if (teacherName != null) {
      companion = companion.copyWith(teacherName: Value(teacherName));
    }
    if (teacherEnName != null) {
      companion = companion.copyWith(teacherEnName: Value(teacherEnName));
    }
    if (teacherUnionId != null) {
      companion = companion.copyWith(teacherUnionId: Value(teacherUnionId));
    }
    if (robotCode != null) {
      companion = companion.copyWith(robotCode: Value(robotCode));
    }
    if (openConversationId != null) {
      companion =
          companion.copyWith(openConversationId: Value(openConversationId));
    }
    if (chatId != null) {
      companion = companion.copyWith(chatId: Value(chatId));
    }
    if (link != null) {
      companion = companion.copyWith(link: Value(link));
    }
    if (assistant != null) {
      companion = companion.copyWith(assistant: Value(assistant));
    }

    return (update(classes)..where((u) => u.id.equals(id))).write(companion);
  }
}
