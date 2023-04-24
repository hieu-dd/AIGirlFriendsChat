import 'package:ai_girl_friends/common/database/database_helper.dart';
import 'package:ai_girl_friends/data/conversation/model/local/local_conversation.dart';
import 'package:sqflite/sqflite.dart';

class ConversationDao {
  final DatabaseHelper databaseHelper = DatabaseHelper.instance;

  Future<int> insertConversation(LocalConversation conversation) async {
    var db = await databaseHelper.db;
    return await db.transaction((txn) async {
      return await txn.insert(
        databaseHelper.conversationTable,
        {
          ...conversation.toDbJson(),
          'updatedAt': DateTime.now().microsecondsSinceEpoch,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
  }

  Future<LocalConversation?> getConversationById(
    int conversationId,
  ) async {
    try {
      var db = await databaseHelper.db;
      var result = await db.transaction((txn) async {
        return await txn.query(
          databaseHelper.conversationTable,
          where: '${databaseHelper.colConversationId}=?',
          whereArgs: [conversationId],
        );
      });
      return LocalConversation.fromDb(result.first);
    } catch (e) {
      return null;
    }
  }

  Future<List<LocalConversation>> getAllConversations() async {
    var db = await databaseHelper.db;
    var result = await db.transaction((txn) async {
      return await txn.query(
        databaseHelper.conversationTable,
      );
    });
    return result.map((e) => LocalConversation.fromDb(e)).toList();
  }
}
