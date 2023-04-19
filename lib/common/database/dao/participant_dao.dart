import 'package:ai_girl_friends/common/database/database_helper.dart';
import 'package:ai_girl_friends/domain/conversation/model/participant.dart';
import 'package:sqflite/sqflite.dart';

class ParticipantDao {
  final DatabaseHelper databaseHelper = DatabaseHelper.instance;

  Future<int> insertParticipant(Participant user) async {
    var db = await databaseHelper.db;
    return await db.transaction((txn) async {
      return await txn.insert(
        databaseHelper.participantTable,
        {
          ...user.toDbJson(),
          'updatedAt': DateTime.now().microsecondsSinceEpoch,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
  }

  Future<List<Participant>> getParticipantsByConversationId(
      int conversationId) async {
    var db = await databaseHelper.db;
    var result = await db.transaction((txn) async {
      return await txn.query(
        databaseHelper.participantTable,
        where: '${databaseHelper.colParticipantConversationId}=?',
        whereArgs: [conversationId],
      );
    });
    return result.map((e) => Participant.fromDbJson(e)).toList();
  }
}
