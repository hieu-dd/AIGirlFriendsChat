import 'package:ai_girl_friends/domain/conversation/repository/conversation_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../di/injection.dart';
import '../domain/conversation/model/conversation.dart';
import '../domain/user/model/user.dart';

class ConversationsNotifier extends ChangeNotifier {
  final ConversationRepository conversationRepository;

  ConversationsNotifier(this.conversationRepository) {
    conversationRepository.getAllConversation().listen((event) {
      _allConversations = event;
      notifyListeners();
    });
  }

  List<Conversation> _allConversations = [];

  List<Conversation> get allConversation => _allConversations;

  Future<void> insertConversation(Conversation conversation) async {
    await conversationRepository.insertConversation(conversation);
  }

  Future<void> insertConversations(List<Conversation> conversations) async {
    final futures = conversations.map((conversation) async {
      await insertConversation(conversation);
    });
    await Future.wait(futures);
  }

  Future<void> createSingleConversations(List<User> users) async {
    final ids = users.map((user) async =>
        await conversationRepository.createSingleConversation(user));
    await Future.wait(ids);
  }

  Future<int?> getConversationByUser(User user) async {
    return await conversationRepository.getConversationByUser(user);
  }
}

final conversationsProvider =
    ChangeNotifierProvider<ConversationsNotifier>((ref) => getIt());
