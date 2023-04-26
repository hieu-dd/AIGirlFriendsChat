import 'package:ai_girl_friends/domain/conversation/model/conversation.dart';

import '../../user/model/user.dart';

abstract class ConversationRepository {
  Future<List<Conversation>> getAllConversation();

  Future<Conversation?> getConversationById(int conversationId);

  Future<int> insertConversation(Conversation conversation);

  Stream<int> sendMessage(int conversationId, String message);

  Future<int> createSingleConversation(User user);
}
