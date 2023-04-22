import 'package:ai_girl_friends/common/database/dao/conversation_dao.dart';
import 'package:ai_girl_friends/common/database/dao/message_dao.dart';
import 'package:ai_girl_friends/common/database/dao/participant_dao.dart';
import 'package:ai_girl_friends/common/database/dao/user_dao.dart';
import 'package:ai_girl_friends/data/conversation/model/local/local_conversation.dart';
import 'package:ai_girl_friends/data/conversation/model/local/local_message.dart';
import 'package:ai_girl_friends/data/conversation/model/local/local_participant.dart';
import 'package:ai_girl_friends/domain/conversation/model/conversation.dart';
import 'package:ai_girl_friends/domain/conversation/model/message.dart';

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
      return await _getConversationFromLocal(conversation);
    });
    final results = await Future.wait(futures);
    return results.toList();
  }

  Future<Conversation> _getConversationFromLocal(
      LocalConversation local) async {
    final conversationId = local.id!;
    final futureParticipants =
        (await participantDao.getParticipantsByConversationId(conversationId))
            .map((p) async => await _getUserFromParticipant(p))
            .toList();
    final participants = await Future.wait(futureParticipants);
    final messages =
        (await messageDao.getMessagesByConversationId(conversationId))
            .map((local) => _getMessageFromLocal(
                  local,
                  participants,
                ))
            .toList();

    return Conversation(
      id: conversationId,
      type: ConversationType.values[local.type],
      creator: participants.firstWhere((p) => p.id == local.creator),
      participants: participants,
      messages: messages,
    );
  }

  @override
  Future<void> insertConversation(Conversation conversation) async {
    final conversationId = await conversationDao
        .insertConversation(LocalConversation.fromDomain(conversation));
    final insertParticipants = conversation.participants.map((user) async {
      await userDao.insertUser(user);
      await participantDao
          .insertParticipant(LocalParticipant.fromUser(conversationId, user));
    });
    final insertMessages = conversation.messages.map((message) async {
      message.conversationId = conversationId;
      await messageDao.insertMessage(LocalMessage.fromDomain(message));
    });
    await Future.wait(insertParticipants);
    await Future.wait(insertMessages);
  }

  Message _getMessageFromLocal(LocalMessage local, List<User> participants) {
    final sender = participants.firstWhere((p) => p.id == local.sender);
    return Message(
      id: local.id,
      conversationId: local.conversationId,
      message: local.message,
      sender: sender,
    )
      ..updatedAt = local.updatedAt
      ..createdAt = local.createdAt;
  }

  Future<User> _getUserFromParticipant(LocalParticipant participant) async {
    return await userDao.getUserById(participant.userId);
  }
}
