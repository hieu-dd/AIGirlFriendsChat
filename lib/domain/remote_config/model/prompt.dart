import 'package:ai_girl_friends/domain/remote_config/model/System_prompt.dart';

class Prompt extends SystemPrompt {
  final int id;
  final int characterId;
  final String content;
  final String randomContent;
  final int milestone;

  Prompt({
    required this.id,
    required this.characterId,
    required this.content,
    required this.randomContent,
    required this.milestone,
  });

  Prompt.fromJson(dynamic json)
      : id = json['id'],
        characterId = json['character_id'],
        content = json['content'],
        randomContent = json['random_content'],
        milestone = json['milestone'];

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['character_id'] = characterId;
    map['content'] = content;
    map['random_content'] = randomContent;
    map['milestone'] = milestone;
    return map;
  }
}
