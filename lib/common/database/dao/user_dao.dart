import 'package:ai_girl_friends/common/database/database_helper.dart';
import 'package:ai_girl_friends/data/user/model/local/local_user.dart';
import 'package:sqflite/sqflite.dart';

import '../../../domain/user/model/user.dart';

class UserDao {
  final DatabaseHelper databaseHelper = DatabaseHelper.instance;

  Future<int> insertUser(User user) async {
    var db = await databaseHelper.db;
    return await db.transaction((txn) async {
      return await txn.insert(
        databaseHelper.userTable,
        {
          ...LocalUser.fromDomain(user).toDbJson(),
          'updatedAt': DateTime.now().microsecondsSinceEpoch,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
  }

  Future<User> getUserById(String userId) async {
    var db = await databaseHelper.db;
    var result = await db.transaction((txn) async {
      return await txn.query(
        databaseHelper.userTable,
        where: '${databaseHelper.colUserId}=?',
        whereArgs: [userId],
      );
    });
    return LocalUser.fromJson(result.first).toDomainUser();
  }

  Future<User> findMe() async {
    var db = await databaseHelper.db;
    var result = await db.query(
      databaseHelper.userTable,
      where: '${databaseHelper.colUserIsMe}=?',
      whereArgs: [1],
    );
    return LocalUser.fromJson(result.first).toDomainUser();
  }
}
