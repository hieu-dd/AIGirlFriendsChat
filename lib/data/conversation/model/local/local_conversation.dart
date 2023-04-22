import 'package:ai_girl_friends/domain/conversation/model/conversation.dart';

class LocalConversation {
  final int? id;
  final int type;
  final String title;
  late String creator;
  late int createdAt;
  late int updatedAt;

  LocalConversation({
    this.id,
    required this.type,
    required this.creator,
    required this.title,
  }) {
    createdAt = DateTime.now().microsecondsSinceEpoch;
    updatedAt = DateTime.now().microsecondsSinceEpoch;
  }

  Map<String, dynamic> toDbJson() => {
        'id': id,
        'type': type,
        'creator': creator,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };

  factory LocalConversation.fromDb(
    Map<String, dynamic> json,
  ) =>
      LocalConversation(
        id: json['id'],
        type: json['type'],
        title: json['title'] ?? "",
        creator: json['creator'],
      )
        ..createdAt = json['createdAt']
        ..updatedAt = json['updatedAt'];

  factory LocalConversation.fromDomain(Conversation conversation) =>
      LocalConversation(
          id: conversation.id,
          type: conversation.type.index,
          creator: conversation.creator.id,
          title: "")
        ..createdAt = conversation.createdAt
        ..updatedAt = conversation.updatedAt;
}
