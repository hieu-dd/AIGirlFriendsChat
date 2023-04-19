import 'package:ai_girl_friends/domain/user/model/user.dart';

class Message {
  final int id;
  final int conversationId;
  late User sender;
  final String message;
  late int createdAt;
  late int updatedAt;

  Message({
    required this.id,
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
        'sender': sender.id,
        'message': message,
        'createdAt': createdAt,
        'updatedAt': updatedAt
      };

  factory Message.fromDbJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      conversationId: json['conversationId'],
      message: json['message'],
      sender: User.fromId(json['sender']),
    )
      ..createdAt = json['createdAt']
      ..updatedAt = json['updatedAt'];
  }
}
