import 'package:ai_girl_friends/common/database/dao/conversation_dao.dart';
import 'package:ai_girl_friends/common/database/dao/message_dao.dart';
import 'package:ai_girl_friends/common/database/dao/participant_dao.dart';
import 'package:ai_girl_friends/common/database/dao/user_dao.dart';
import 'package:ai_girl_friends/data/conversation/model/local/local_conversation.dart';
import 'package:ai_girl_friends/data/conversation/model/local/local_message.dart';
import 'package:ai_girl_friends/data/conversation/model/local/local_participant.dart';
import 'package:ai_girl_friends/data/conversation/model/remote/remote_message.dart';
import 'package:ai_girl_friends/data/conversation/model/remote/send_turbo_messages.dart';
import 'package:ai_girl_friends/domain/conversation/model/conversation.dart';
import 'package:ai_girl_friends/domain/conversation/model/message.dart';

import '../../../domain/conversation/repository/conversation_repository.dart';
import '../../../domain/user/model/user.dart';
import '../datasource/conversation_api.dart';

class ConversationRepositoryImpl implements ConversationRepository {
  final ConversationDao conversationDao;
  final ParticipantDao participantDao;
  final MessageDao messageDao;
  final UserDao userDao;
  final ConversationApi conversationApi;

  ConversationRepositoryImpl({
    required this.conversationDao,
    required this.participantDao,
    required this.messageDao,
    required this.userDao,
    required this.conversationApi,
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

  @override
  Future<Conversation?> getConversationById(int conversationId) async {
    final conversation =
        await conversationDao.getConversationById(conversationId);
    return conversation != null
        ? _getConversationFromLocal(conversation)
        : null;
  }

  @override
  Future<int?> getConversationByUser(User user) async {
    return (await conversationDao.getConversationByUser(user.id))?.id;
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
            .toList()
          ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return Conversation(
      id: conversationId,
      type: ConversationType.values[local.type],
      creator: participants.firstWhere((p) => p.id == local.creator),
      participants: participants,
      messages: messages,
    );
  }

  @override
  Future<int> insertConversation(Conversation conversation) async {
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
    return conversationId;
  }

  @override
  Stream<int> sendMessage(int conversationId, String message) async* {
    final conversation = await getConversationById(conversationId);
    if (conversation == null) {
      yield 0;
    } else {
      final me = await userDao.findMe();
      final mes =
          Message(conversationId: conversationId, message: message, sender: me);
      yield await _insertMessageToConversation(mes, conversation);
      final response = await conversationApi.sendMessage(
          SendTurboMessagesRequest(
              messages: [RemoteMessage(role: 'user', content: message)]));
      final responseMes = Message(
          conversationId: conversationId,
          message: response.content,
          sender: conversation.participants
              .firstWhere((participant) => participant.isMe));
      yield await _insertMessageToConversation(responseMes, conversation);
    }
  }

  @override
  Future<int> createSingleConversation(User user) async {
    final local = await conversationDao.getConversationByUser(user.id);
    if (local != null) {
      return (await _getConversationFromLocal(local)).id!;
    } else {
      final me = await userDao.findMe();
      final newConversation = Conversation(
        type: ConversationType.single,
        creator: me,
        participants: [me, user],
        messages: [],
      );
      return await insertConversation(newConversation);
    }
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

  Future<int> _insertMessageToConversation(
      Message message, Conversation conversation) async {
    final newConversation = Conversation(
        id: conversation.id,
        type: conversation.type,
        creator: conversation.creator,
        participants: [...conversation.participants, message.sender],
        messages: [message, ...conversation.messages])
      ..createdAt = conversation.createdAt;
    return await insertConversation(newConversation);
  }
}
