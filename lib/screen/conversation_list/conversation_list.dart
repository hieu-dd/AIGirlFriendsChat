import 'package:ai_girl_friends/provider/conversations_provider.dart';
import 'package:ai_girl_friends/screen/chat/chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ConversationListScreen extends ConsumerStatefulWidget {
  static const direction = '/conversation_list';

  const ConversationListScreen({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _ConversationListState();
}

class _ConversationListState extends ConsumerState<ConversationListScreen> {
  Future<void> setupData() async {}

  @override
  Widget build(BuildContext context) {
    final conversations = ref.watch(conversationsProvider).allConversation;
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: conversations
            .map((conversation) => InkWell(
                  onTap: () {
                    context.goNamed(ChatScreen.direction, params: {
                      ChatScreen.argConversationId: conversation.id.toString()
                    });
                  },
                  child: ListTile(
                    title: Text(conversation.id.toString()),
                    subtitle: Text(conversation.messages.isNotEmpty
                        ? "${conversation.messages.first.message}  ${conversation.participants.length}      ${conversation.messages.length}"
                        : ""),
                  ),
                ))
            .toList(),
      ),
    ));
  }
}
