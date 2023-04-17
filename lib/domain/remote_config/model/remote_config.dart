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
}
