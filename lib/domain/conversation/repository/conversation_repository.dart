import 'package:ai_girl_friends/domain/conversation/model/conversation.dart';

abstract class ConversationRepository {
  Future<List<Conversation>> getAllConversation();

  Future<Conversation?> getConversationById(int conversationId);

  Future<int> insertConversation(Conversation conversation);

  Future<int> sendMessage(int conversationId, String message);
}
