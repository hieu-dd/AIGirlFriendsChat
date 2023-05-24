import 'package:ai_girl_friends/domain/conversation/model/conversation.dart';
import 'package:ai_girl_friends/ext/list_ext.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../di/injection.dart';
import '../domain/conversation/model/message.dart';
import '../domain/conversation/repository/conversation_repository.dart';

class ConversationNotifier extends ChangeNotifier {
  final ConversationRepository conversationRepository;

  ConversationNotifier(this.conversationRepository);

  Conversation? _conversation;
  int? _conversationId;
  bool _waitResponse = false;

  Conversation? get conversation {
    if (_conversation == null) return null;
    final messages = _conversation?.messages ?? [];
    return _conversation?.copy(messages: [
      if (waitResponse)
        Message(
          conversationId: _conversation!.id ?? 0,
          message: "",
          sender: _conversation!.participants.firstWhere((user) => !user.isMe),
          status: MessageStatus.typing,
        ),
      ...messages
    ]);
  }

  bool get waitResponse => _waitResponse;

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
      if (result?.messages.tryFirst()?.sender.isMe == false) {
        _waitResponse = false;
      }
      notifyListeners();
    }
  }

  void sendMessage(String message) async {
    _waitResponse = true;
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
