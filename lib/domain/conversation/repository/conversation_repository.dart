import 'package:ai_girl_friends/domain/conversation/model/conversation.dart';

abstract class ConversationRepository {
  Future<List<Conversation>> getAllConversation();
  Future<void> insertConversation(Conversation conversation);
}
