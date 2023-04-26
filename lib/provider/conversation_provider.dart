import 'package:ai_girl_friends/domain/conversation/model/conversation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../di/injection.dart';
import '../domain/conversation/repository/conversation_repository.dart';

class ConversationNotifier extends ChangeNotifier {
  final ConversationRepository conversationRepository;

  ConversationNotifier(this.conversationRepository);

  Conversation? _conversation;
  int? _conversationId;

  Conversation? get conversation => _conversation;

  void getLocalConversation(int conversationId) async {
    if (_conversationId != conversationId) {
      _conversation = null;
      _conversationId = conversationId;
      notifyListeners();
    }

    final result =
        await conversationRepository.getConversationById(conversationId);
    if (result != _conversation) {
      _conversation = result;
      notifyListeners();
    }
  }

  void sendMessage(String message) async {
    conversationRepository
        .sendMessage(_conversationId!, message)
        .listen((messageId) {
      if (messageId != 0) {
        getLocalConversation(_conversationId!);
      }
    });
  }
}

final conversationProvider =
    ChangeNotifierProvider<ConversationNotifier>((ref) => getIt());
