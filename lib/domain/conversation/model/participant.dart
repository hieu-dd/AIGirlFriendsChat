class Participant {
  final int conversationId;
  final String userId;
  late int createdAt;
  late int updatedAt;

  Participant({required this.conversationId, required this.userId}) {
    createdAt = DateTime.now().microsecondsSinceEpoch;
    updatedAt = DateTime.now().microsecondsSinceEpoch;
  }

  Map<String, dynamic> toDbJson() => <String, dynamic>{
        'conversationId': conversationId,
        'userId': userId,
        'createdAt': createdAt,
        'updatedAt': updatedAt
      };

  factory Participant.fromDbJson(Map<String, dynamic> json) => Participant(
        conversationId: json['conversationId'],
        userId: json['userId'],
      )
        ..createdAt = json['createdAt']
        ..updatedAt = json['updatedAt'];
}
