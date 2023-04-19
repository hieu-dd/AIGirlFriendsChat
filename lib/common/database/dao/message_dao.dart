import 'package:ai_girl_friends/common/database/database_helper.dart';
import 'package:ai_girl_friends/domain/conversation/model/message.dart';
import 'package:sqflite/sqflite.dart';

class MessageDao {
  final DatabaseHelper databaseHelper = DatabaseHelper.instance;

  Future<int> insertMessage(Message message) async {
    var db = await databaseHelper.db;
    return await db.insert(
      databaseHelper.messageTable,
      {
        ...message.toDbJson(),
        'updatedAt': DateTime.now().microsecondsSinceEpoch,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Message>> getMessagesByConversationId(
    int conversationId,
  ) async {
    var db = await databaseHelper.db;
    var result = await db.query(
      databaseHelper.messageTable,
      where: '${databaseHelper.colMessageConversationId}=?',
      whereArgs: [conversationId],
    );
    return result.map((e) {
      return Message.fromDbJson(e);
    }).toList();
  }
}
