import '../../user/model/user.dart';
import 'message.dart';

class Conversation {
  final int id;
  final ConversationType type;
  final User creator;
  final List<User> participants;
  final List<Message> messages;
  final String createdAt;
  final String updatedAt;

  Conversation({
    required this.id,
    required this.type,
    required this.creator,
    required this.participants,
    required this.messages,
    required this.createdAt,
    required this.updatedAt,
  });
}

enum ConversationType { single, group }
