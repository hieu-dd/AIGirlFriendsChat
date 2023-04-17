import 'package:ai_girl_friends/domain/user/model/user.dart';

class Message {
  final int id;
  final User sender;
  final String message;
  final String createdAt;
  final String updateAt;

  Message({
    required this.id,
    required this.sender,
    required this.message,
    required this.createdAt,
    required this.updateAt,
  });
}
