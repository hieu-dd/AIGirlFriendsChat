import 'prompt.dart';
import 'system_prompt.dart';

class RemoteConfig {
  final String userPrompt;
  final int userMessageCount;
  final int randomRange;
  final List<Prompt> prompts;
  final List<SystemPrompt> systemPrompts;

  RemoteConfig({
    required this.userPrompt,
    required this.userMessageCount,
    required this.randomRange,
    required this.prompts,
    required this.systemPrompts,
  });

  RemoteConfig.fromJson(dynamic json)
      : userPrompt = json['userPrompt'],
        randomRange = json['randomRange'],
        userMessageCount = json['userMessageCount'],
        prompts = (json['prompts'] as List<dynamic>)
            .map((e) => Prompt.fromJson(e))
            .toList(),
        systemPrompts = (json['systemPrompts'] as List<dynamic>)
            .map((e) => SystemPrompt.fromJson(e))
            .toList();

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userPrompt'] = userPrompt;
    map['userMessageCount'] = userMessageCount;
    map['randomRange'] = randomRange;
    map['prompts'] = prompts.map((e) => e.toJson()).toList();
    map['systemPrompts'] = systemPrompts.map((e) => e.toJson()).toList();
    return map;
  }
}
