import 'package:ai_girl_friends/domain/conversation/repository/conversation_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../di/injection.dart';
import '../domain/conversation/model/conversation.dart';

class ConversationNotifier extends ChangeNotifier {
  final ConversationRepository conversationRepository;

  ConversationNotifier(this.conversationRepository);

  List<Conversation> _allConversations = [];

  List<Conversation> get allConversation => _allConversations;

  Future<void> getAllConversations() async {
    _allConversations = await conversationRepository.getAllConversation();
    notifyListeners();
  }

  Future<void> insertConversation(Conversation conversation) async {
    await conversationRepository.insertConversation(conversation);
    getAllConversations();
  }

  Future<void> insertConversations(List<Conversation> conversations) async {
    conversations.forEach((conversation) async {
      await insertConversation(conversation);
    });
    getAllConversations();
  }
}

final conversationProvider =
    ChangeNotifierProvider<ConversationNotifier>((ref) => getIt());