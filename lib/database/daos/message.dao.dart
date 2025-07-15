import 'package:drift/drift.dart';
import 'package:intl/intl.dart';
import 'package:wingapp/database/database.dart';
import 'package:wingapp/database/tables.dart';
import 'package:wingapp/models/normal_response.model.dart';

part 'message.dao.g.dart';

@DriftAccessor(
    tables: [Messages], queries: {'countAll': 'SELECT COUNT(*) FROM messages;'})
class MessageDao extends DatabaseAccessor<AppDatabase> with _$MessageDaoMixin {
  // 构造方法是必需的，这样主数据库可以创建这个对象的实例。
  // ignore: use_super_parameters
  MessageDao(AppDatabase db) : super(db);

  Future<int> createMessage({
    required String id,
    required String classId,
    required String content,
    required String senderId,
    required String senderName,
    String? senderAvatar,
    String? type,
    bool? isRobot,
    String? from,
  }) {
    return into(messages).insertOnConflictUpdate(MessagesCompanion(
      id: Value(id),
      classId: Value(classId),
      content: Value(content),
      senderId: Value(senderId),
      senderName: Value(senderName),
      senderAvatar: Value(senderAvatar ?? ''),
      type: Value(type ?? ''),
      isRobot: Value(isRobot ?? false),
      from: Value(from ?? ''),
      createAt: Value(DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())),
    ));
  }

  Future<NormalResponse> getMessages({
    required String classId,
    int? pageIndex = 1,
    int? pageSize = 20,
  }) async {
    int totalCount = await (select(messages)
          ..where((message) => message.classId.equals(classId)))
        .get()
        .then((value) => value.length);
    int totalPage = (totalCount / pageSize!).ceil();

    int countInLastPage = totalCount % pageSize;

    int offset = (totalPage - pageIndex!) > 0
        ? (totalPage - pageIndex - 1) * pageSize + countInLastPage
        : 0;

    final msgs = await (select(messages)
          ..where((message) => message.classId.equals(classId))
          ..orderBy([(tbl) => OrderingTerm.asc(tbl.createAt)])
          ..limit(pageSize, offset: offset))
        .get();

    return NormalResponse(
      code: 200,
      data: {
        'list': msgs,
        'totalCount': totalCount,
        'totalPage': totalPage,
        'pageIndex': pageIndex,
        'pageSize': pageSize,
      },
      message: 'success',
    );
  }
}
