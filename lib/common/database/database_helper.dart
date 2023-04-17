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
  String colUpdateAt = 'updateAt';

  // Conversation table
  String colConversationId = 'id';
  String colConversationTitle = 'title';
  String colConversationType = 'type';
  String colConversationCreator = 'creator';

  // Message table
  String colMessageId = 'id';
  String colMessageConversationId = 'conversation_id';
  String colMessageSender = 'sender';
  String colMessageMessage = 'message';

  // User table
  String colUserId = 'id';
  String colUserName = 'name';
  String colUserAge = 'age';
  String colUserGender = 'gender';

  // Participant table
  String colParticipantUserId = 'user_id';
  String colParticipantConversationId = 'conversation_id';

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
        'CREATE TABLE $conversationTable($colConversationId INTEGER PRIMARY KEY AUTOINCREMENT, $colConversationType TEXT NOT NULL, $colConversationCreator TEXT, $colConversationCreator TEXT NOT NULL, $colCreatedAt TEXT NOT NULL, $colUpdateAt TEXT NOT NULL)');
    await db.execute(
        'CREATE TABLE $messageTable($colMessageId INTEGER PRIMARY KEY AUTOINCREMENT, $colMessageConversationId INTEGER, $colMessageSender TEXT NOT NULL, $colMessageMessage TEXT NOT NULL, $colCreatedAt TEXT NOT NULL, $colUpdateAt TEXT NOT NULL, FOREIGN KEY($colMessageConversationId) REFERENCES $conversationTable($colConversationId))');
    await db.execute(
        'CREATE TABLE $userTable($colUserId TEXT PRIMARY KEY, $colUserName TEXT NOT NULL ,$colUserAge INTEGER NOT NULL, $colUserGender TEXT NOT NULL, $colCreatedAt TEXT NOT NULL, $colUpdateAt TEXT NOT NULL)');
    await db.execute(
        'CREATE TABLE $participantTable($colParticipantUserId TEXT, $colParticipantConversationId INTEGER, $colCreatedAt TEXT NOT NULL, $colUpdateAt TEXT NOT NULL, FOREIGN KEY($colParticipantUserId) REFERENCES $userTable($colUserId), FOREIGN KEY($colParticipantConversationId) REFERENCES $conversationTable($colConversationId))');
  }
}