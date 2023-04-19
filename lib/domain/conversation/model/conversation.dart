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

  Map<String, dynamic> toDbJson() => {
        'id': id,
        'type': type.index,
        'creator': creator.id,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };

  factory Conversation.fromDb(
    Map<String, dynamic> json,
  ) =>
      Conversation(
        id: json['id'],
        type: ConversationType.values[json['type']],
        creator: User.fromId(json['creator']),
        participants: [],
        messages: [],
      )
        ..createdAt = json['createdAt']
        ..updatedAt = json['updatedAt'];
}

enum ConversationType { single, group }
