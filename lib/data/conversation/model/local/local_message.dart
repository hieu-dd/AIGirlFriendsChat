import 'package:ai_girl_friends/domain/conversation/model/message.dart';

class LocalMessage {
  int? id;
  final int conversationId;
  late String sender;
  final String message;
  late int createdAt;
  late int updatedAt;

  LocalMessage({
    this.id,
    required this.conversationId,
    required this.message,
    required this.sender,
  }) {
    createdAt = DateTime.now().microsecondsSinceEpoch;
    updatedAt = DateTime.now().microsecondsSinceEpoch;
  }

  Map<String, dynamic> toDbJson() => <String, dynamic>{
        'id': id,
        'conversationId': conversationId,
        'sender': sender,
        'message': message,
        'createdAt': createdAt,
        'updatedAt': updatedAt
      };

  factory LocalMessage.fromDbJson(Map<String, dynamic> json) {
    return LocalMessage(
      id: json['id'],
      conversationId: json['conversationId'],
      message: json['message'],
      sender: json['sender'],
    )
      ..createdAt = json['createdAt']
      ..updatedAt = json['updatedAt'];
  }

  factory LocalMessage.fromDomain(Message message) => LocalMessage(
        id: message.id,
        conversationId: message.conversationId,
        message: message.message,
        sender: message.sender.id,
      )
        ..createdAt = message.createdAt
        ..updatedAt = message.updatedAt;
}
