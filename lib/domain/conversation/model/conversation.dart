import 'package:equatable/equatable.dart';

import '../../user/model/user.dart';
import 'message.dart';

class Conversation extends Equatable {
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

  Conversation copy({List<Message>? messages}) => Conversation(
        id: id,
        type: type,
        creator: creator,
        participants: participants,
        messages: messages ?? this.messages,
      )
        ..createdAt = createdAt
        ..updatedAt = updatedAt;

  @override
  List<Object?> get props => [
        id,
        type,
        creator.id,
        participants,
        messages,
        createdAt,
        updatedAt,
      ];
}

enum ConversationType { single, group }
