import '../../user/model/user.dart';
import 'message.dart';

class Conversation {
  final int id;
  final ConversationType type;
  final User creator;
  final List<User> participants;
  final List<Message> messages;
  late int createdAt;
  late int updatedAt;

  Conversation({
    required this.id,
    required this.type,
    required this.creator,
    required this.participants,
    required this.messages,
  }) {
    createdAt = DateTime.now().microsecondsSinceEpoch;
    updatedAt = DateTime.now().microsecondsSinceEpoch;
  }
}

enum ConversationType { single, group }
