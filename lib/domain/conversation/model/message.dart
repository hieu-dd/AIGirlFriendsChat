import 'package:ai_girl_friends/domain/user/model/user.dart';

class Message {
  final int id;
  int conversationId;
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
}
