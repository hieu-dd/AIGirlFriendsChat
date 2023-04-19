import 'package:ai_girl_friends/common/database/database_helper.dart';
import 'package:ai_girl_friends/domain/conversation/model/conversation.dart';
import 'package:sqflite/sqflite.dart';

class ConversationDao {
  final DatabaseHelper databaseHelper = DatabaseHelper.instance;

  Future<int> insertConversation(Conversation conversation) async {
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

  Future<Conversation> getConversationById(
    int conversationId,
  ) async {
    var db = await databaseHelper.db;
    var result = await db.transaction((txn) async {
      return await txn.query(
        databaseHelper.conversationTable,
        where: '${databaseHelper.colConversationId}=?',
        whereArgs: [conversationId],
      );
    });
    return Conversation.fromDb(result.first);
  }

  Future<List<Conversation>> getAllConversations() async {
    var db = await databaseHelper.db;
    var result = await db.transaction((txn) async {
      return await txn.query(
        databaseHelper.conversationTable,
      );
    });
    return result.map((e) => Conversation.fromDb(e)).toList();
  }
}
