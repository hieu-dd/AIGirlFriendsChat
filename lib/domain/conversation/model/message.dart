import 'package:ai_girl_friends/domain/user/model/user.dart';

class Message {
  final int id;
  final User sender;
  final String message;
  late int createdAt;
  late int updatedAt;

  Message({
    required this.id,
    required this.sender,
    required this.message,
  }) {
    createdAt = DateTime.now().microsecondsSinceEpoch;
    updatedAt = DateTime.now().microsecondsSinceEpoch;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'sender': sender.id,
        'message': message,
        'createdAt': createdAt,
        'updatedAt': updatedAt
      };
}
