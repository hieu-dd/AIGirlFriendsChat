class SystemPrompt {
  final String characterId;
  final String content;

  SystemPrompt({
    required this.characterId,
    required this.content,
  });

  SystemPrompt.fromJson(dynamic json)
      : characterId = json['character_id'].toString(),
        content = json['content'];

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['character_id'] = characterId;
    map['content'] = content;
    return map;
  }
}
