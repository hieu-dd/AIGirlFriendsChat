import 'package:ai_girl_friends/common/database/dao/conversation_dao.dart';
import 'package:ai_girl_friends/common/database/dao/message_dao.dart';
import 'package:ai_girl_friends/common/database/dao/participant_dao.dart';
import 'package:ai_girl_friends/common/database/dao/user_dao.dart';
import 'package:ai_girl_friends/domain/conversation/model/conversation.dart';
import 'package:ai_girl_friends/domain/conversation/model/participant.dart';

import '../../../domain/conversation/repository/conversation_repository.dart';
import '../../../domain/user/model/user.dart';

class ConversationRepositoryImpl implements ConversationRepository {
  final ConversationDao conversationDao;
  final ParticipantDao participantDao;
  final MessageDao messageDao;
  final UserDao userDao;

  ConversationRepositoryImpl({
    required this.conversationDao,
    required this.participantDao,
    required this.messageDao,
    required this.userDao,
  });

  @override
  Future<List<Conversation>> getAllConversation() async {
    final conversations = await conversationDao.getAllConversations();
    final futures = conversations.map((conversation) async {
      return await _updateConversation(conversation);
    });
    final results = await Future.wait(futures);
    return results.toList();
  }

  Future<Conversation> _updateConversation(Conversation conversation) async {
    final conversationId = conversation.id!;
    final participants =
        (await participantDao.getParticipantsByConversationId(conversationId))
            .map((e) => User.fromId(e.userId))
            .toList();
    final messages =
        await messageDao.getMessagesByConversationId(conversationId);
    conversation.participants = participants;
    conversation.messages = messages;

    return conversation;
  }

  @override
  Future<void> insertConversation(Conversation conversation) async {
    final conversationId =
        await conversationDao.insertConversation(conversation);
    conversation.participants.forEach((user) async {
      await userDao.insertUser(user);
      final participantId = await participantDao.insertParticipant(
          Participant(conversationId: conversationId, userId: user.id));
      print(participantId);
    });
    conversation.messages.forEach((message) async {
      final messageId = await messageDao.insertMessage(message);
      print(messageId);
    });
  }
}
