import 'package:ai_girl_friends/domain/remote_config/model/System_prompt.dart';

class Prompt extends SystemPrompt {
  final int id;
  final String randomContent;
  final int milestone;

  Prompt({
    required this.id,
    required super.characterId,
    required super.content,
    required this.randomContent,
    required this.milestone,
  });

  Prompt.fromJson(dynamic json)
      : id = json['id'],
        randomContent = json['random_content'],
        milestone = json['milestone'],
        super.fromJson(json);

  @override
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
