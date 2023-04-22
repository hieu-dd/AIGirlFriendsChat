import 'package:ai_girl_friends/common/database/database_helper.dart';
import 'package:ai_girl_friends/data/conversation/model/local/local_message.dart';
import 'package:sqflite/sqflite.dart';

class MessageDao {
  final DatabaseHelper databaseHelper = DatabaseHelper.instance;

  Future<int> insertMessage(LocalMessage local) async {
    var db = await databaseHelper.db;
    return await db.transaction((txn) async {
      return txn.insert(
        databaseHelper.messageTable,
        {
          ...local.toDbJson(),
          'updatedAt': DateTime.now().microsecondsSinceEpoch,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
  }

  Future<List<LocalMessage>> getMessagesByConversationId(
    int conversationId,
  ) async {
    var db = await databaseHelper.db;
    var result = await db.transaction((txn) async {
      return await txn.query(
        databaseHelper.messageTable,
        where: '${databaseHelper.colMessageConversationId}=?',
        whereArgs: [conversationId],
      );
    });
    return result.map((e) {
      return LocalMessage.fromDbJson(e);
    }).toList();
  }
}
