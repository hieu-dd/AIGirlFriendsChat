import 'dart:math';

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
import 'package:ai_girl_friends/domain/remote_config/model/remote_config.dart';
import 'package:ai_girl_friends/ext/list_ext.dart';

import '../../../domain/conversation/repository/conversation_repository.dart';
import '../../../domain/remote_config/usecase/get_remote_config.dart';
import '../../../domain/user/model/user.dart';
import '../datasource/conversation_api.dart';

class ConversationRepositoryImpl implements ConversationRepository {
  final ConversationDao conversationDao;
  final ParticipantDao participantDao;
  final MessageDao messageDao;
  final UserDao userDao;
  final ConversationApi conversationApi;
  final GetRemoteConfig getRemoteConfig;

  ConversationRepositoryImpl(
      {required this.conversationDao,
      required this.participantDao,
      required this.messageDao,
      required this.userDao,
      required this.conversationApi,
      required this.getRemoteConfig});

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
      final receiver = conversation.participants.firstWhere(
        (participant) => !participant.isMe,
      );
      final sendMessage = Message(
          conversationId: conversationId,
          message: message,
          sender: me,
          status: MessageStatus.sending);
      final sentId =
          await _insertMessageToSingleConversation(sendMessage, conversationId);
      yield sentId;
      final typing = Message(
        conversationId: conversationId,
        message: "",
        sender: receiver,
        status: MessageStatus.typing,
      );
      final waitId =
          await _insertMessageToSingleConversation(typing, conversationId);
      yield waitId;
      try {
        final request = await _createSendMessageRequest(message, conversation);
        final response = await conversationApi.sendMessage(request);
        final responseMes = Message(
            id: waitId,
            conversationId: conversationId,
            message: response.content,
            sender: conversation.participants.firstWhere(
              (participant) => !participant.isMe,
            ),
            status: MessageStatus.sent);
        await _insertMessageToSingleConversation(
            sendMessage
              ..id = sentId
              ..status = MessageStatus.sent,
            conversationId);
        yield await _insertMessageToSingleConversation(
          responseMes,
          conversationId,
        );
      } catch (e) {
        final responseMes = Message(
          id: waitId,
          conversationId: conversationId,
          message: "Tôi không thể trả lời lúc này",
          sender: conversation.participants
              .firstWhere((participant) => !participant.isMe),
          status: MessageStatus.fail,
        );
        await _insertMessageToSingleConversation(
            sendMessage
              ..id = sentId
              ..status = MessageStatus.fail,
            conversationId);
        yield await _insertMessageToSingleConversation(
          responseMes,
          conversationId,
        );
      }
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
      status: MessageStatus.values[local.status],
    )
      ..updatedAt = local.updatedAt
      ..createdAt = local.createdAt;
  }

  Future<User> _getUserFromParticipant(LocalParticipant participant) async {
    return await userDao.getUserById(participant.userId);
  }

  Future<int> _insertMessageToConversation(
    Message message,
    Conversation conversation,
  ) async {
    final newConversation = Conversation(
        id: conversation.id,
        type: conversation.type,
        creator: conversation.creator,
        participants: [...conversation.participants, message.sender],
        messages: [message, ...conversation.messages])
      ..createdAt = conversation.createdAt;
    return await insertConversation(newConversation);
  }

  Future<int> _insertMessageToSingleConversation(
    Message message,
    int conversationId,
  ) {
    return messageDao.insertMessage(LocalMessage.fromDomain(message));
  }

  Future<SendTurboMessagesRequest> _createSendMessageRequest(
    String newMessage,
    Conversation conversation,
  ) async {
    final me = await userDao.findMe();
    final receiverId = conversation.participants
        .firstWhere((participant) => !participant.isMe)
        .id;
    final remoteConfigResult = await getRemoteConfig.call();
    RemoteConfig remoteConfig;
    remoteConfig = remoteConfigResult
        .getOrElse(() => throw Exception('Cannot get remote config'));

    final systemPrompt = remoteConfig.systemPrompts
        .firstWhere((prompt) => prompt.characterId == receiverId)
        .content;
    final userPrompt = remoteConfig.userPrompt
        .replaceAll('{name}', me.name)
        .replaceAll('{age}', me.age.toString())
        .replaceAll('{gender}', me.gender.name)
        .replaceAll('{job}', me.job);
    final prompt = remoteConfig.prompts
        .firstWhere((prompt) => prompt.characterId == receiverId);
    final systemMessage =
        RemoteMessage(role: 'system', content: '$systemPrompt.$userPrompt');
    final chatMessages = conversation.messages
        .where((element) => element.status == MessageStatus.sent)
        .take(remoteConfig.userMessageCount)
        .mapTo((message) {
      final role = message.sender.isMe ? 'user' : 'assistant';
      final useRandom = Random().nextInt(remoteConfig.randomRange) + 1 ==
          remoteConfig.randomRange;
      final content = message.sender.isMe
          ? '${message.message}(${useRandom ? prompt.randomContent : prompt.content})'
          : message.message;

      return RemoteMessage(role: role, content: content);
    });
    final sendMessage =
        RemoteMessage(role: 'user', content: '$newMessage(${prompt.content})');
    final messages = [systemMessage, ...chatMessages.reversed, sendMessage];
    return SendTurboMessagesRequest(messages: messages);
  }
}
