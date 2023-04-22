import 'dart:async';

import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();
  static Database? _db;

  DatabaseHelper._instance();

  String conversationTable = 'conversation';
  String messageTable = 'message';
  String userTable = 'user';
  String participantTable = 'participant';

  //common
  String colCreatedAt = 'createdAt';
  String colUpdateAt = 'updatedAt';

  // Conversation table
  String colConversationId = 'id';
  String colConversationTitle = 'title';
  String colConversationType = 'type';
  String colConversationCreator = 'creator';

  // Message table
  String colMessageId = 'id';
  String colMessageConversationId = 'conversationId';
  String colMessageSender = 'sender';
  String colMessageMessage = 'message';

  // User table
  String colUserId = 'id';
  String colUserName = 'name';
  String colUserAge = 'age';
  String colUserGender = 'gender';
  String colUserIsMe = 'isMe';

  // Participant table
  String colParticipantUserId = 'userId';
  String colParticipantConversationId = 'conversationId';

  Future<Database> get db async {
    _db ??= await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    String dbPath = await getDatabasesPath();
    String path = '${dbPath}aigf_database.db';
    final myDatabase = await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
    return myDatabase;
  }

  void _createDb(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $conversationTable($colConversationId INTEGER PRIMARY KEY AUTOINCREMENT, $colConversationType INTEGER NOT NULL, $colConversationTitle TEXT, $colConversationCreator TEXT NOT NULL, $colCreatedAt INTEGER NOT NULL, $colUpdateAt INTEGER NOT NULL)');
    await db.execute(
        'CREATE TABLE $messageTable($colMessageId INTEGER PRIMARY KEY AUTOINCREMENT, $colMessageConversationId INTEGER NOT NULL, $colMessageSender TEXT NOT NULL, $colMessageMessage TEXT NOT NULL, $colCreatedAt INTEGER NOT NULL, $colUpdateAt INTEGER NOT NULL, FOREIGN KEY($colMessageConversationId) REFERENCES $conversationTable($colConversationId))');
    await db.execute(
        'CREATE TABLE $userTable($colUserId TEXT PRIMARY KEY, $colUserName TEXT NOT NULL ,$colUserAge INTEGER NOT NULL, $colUserGender INTEGER NOT NULL, $colUserIsMe INTEGER NOT NULL ,$colCreatedAt INTEGER NOT NULL, $colUpdateAt INTEGER NOT NULL)');
    await db.execute(
        'CREATE TABLE $participantTable($colParticipantUserId TEXT NOT NULL, $colParticipantConversationId INTEGER NOT NULL, $colCreatedAt INTEGER NOT NULL, $colUpdateAt INTEGER NOT NULL, PRIMARY KEY ($colParticipantUserId, $colParticipantConversationId),FOREIGN KEY($colParticipantUserId) REFERENCES $userTable($colUserId), FOREIGN KEY($colParticipantConversationId) REFERENCES $conversationTable($colConversationId))');
  }
}
