import 'package:ai_girl_friends/domain/user/model/user.dart';

class Message {
  int? id;
  int conversationId;
  late User sender;
  final String message;
  late int createdAt;
  late int updatedAt;

  Message({
    this.id,
    required this.conversationId,
    required this.message,
    required this.sender,
  }) {
    createdAt = DateTime.now().microsecondsSinceEpoch;
    updatedAt = DateTime.now().microsecondsSinceEpoch;
  }
}
