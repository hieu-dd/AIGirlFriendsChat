import 'package:ai_girl_friends/domain/user/model/user.dart';

class LocalParticipant {
  final int conversationId;
  final String userId;
  late int createdAt;
  late int updatedAt;

  LocalParticipant({required this.conversationId, required this.userId}) {
    createdAt = DateTime.now().microsecondsSinceEpoch;
    updatedAt = DateTime.now().microsecondsSinceEpoch;
  }

  Map<String, dynamic> toDbJson() => <String, dynamic>{
        'conversationId': conversationId,
        'userId': userId,
        'createdAt': createdAt,
        'updatedAt': updatedAt
      };

  factory LocalParticipant.fromDbJson(Map<String, dynamic> json) =>
      LocalParticipant(
        conversationId: json['conversationId'],
        userId: json['userId'],
      )
        ..createdAt = json['createdAt']
        ..updatedAt = json['updatedAt'];

  factory LocalParticipant.fromUser(int conversationId, User participant) =>
      LocalParticipant(
        conversationId: conversationId,
        userId: participant.id,
      );
}
