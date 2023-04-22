import '../../user/model/user.dart';
import 'message.dart';

class Conversation {
  final int? id;
  final ConversationType type;
  late User creator;
  late List<User> participants;
  late List<Message> messages;
  late int createdAt;
  late int updatedAt;

  Conversation({
    this.id,
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
