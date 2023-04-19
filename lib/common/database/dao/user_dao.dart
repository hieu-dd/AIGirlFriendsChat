import 'package:ai_girl_friends/common/database/database_helper.dart';
import 'package:ai_girl_friends/domain/user/model/user.dart';
import 'package:sqflite/sqflite.dart';

class UserDao {
  final DatabaseHelper databaseHelper = DatabaseHelper.instance;

  Future<int> insertUser(User user) async {
    var db = await databaseHelper.db;
    return await db.insert(
      databaseHelper.userTable,
      {
        ...user.toJson(),
        'updatedAt': DateTime.now().microsecondsSinceEpoch,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<User> getUserById(String userId) async {
    var db = await databaseHelper.db;
    var result = await db.query(
      databaseHelper.userTable,
      where: '${databaseHelper.colUserId}=?',
      whereArgs: [userId],
    );
    return User.fromJson(result.first);
  }

  Future<User> findMe() async {
    var db = await databaseHelper.db;
    var result = await db.query(
      databaseHelper.userTable,
    );
    return User.fromJson(result.first);
  }
}
