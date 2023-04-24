import 'package:ai_girl_friends/domain/conversation/model/message.dart';
import 'package:ai_girl_friends/provider/conversations_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../domain/conversation/model/conversation.dart';
import '../../domain/user/model/user.dart';

class ConversationListScreen extends ConsumerStatefulWidget {
  const ConversationListScreen({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _ConversationListState();
}

class _ConversationListState extends ConsumerState<ConversationListScreen> {
  @override
  void initState() {
    super.initState();

    ref.read(conversationsProvider.notifier).insertConversations(conversations);
  }

  Future<void> setupData() async {}

  @override
  Widget build(BuildContext context) {
    final conversations = ref.watch(conversationsProvider).allConversation;
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: conversations
            .map((conversation) => ListTile(
                  title: Text(conversation.id.toString()),
                  subtitle: Text(conversation.messages.isNotEmpty
                      ? conversation.messages.first.message +
                          "  " +
                          conversation.participants.length.toString() +
                          "      " +
                          conversation.messages.length.toString()
                      : ""),
                ))
            .toList(),
      ),
    ));
  }
}

User user1 = User(
  id: Uuid().v4(),
  name: 'Hieu1',
  age: 25,
  gender: Gender.male,
  isMe: false,
);
User user2 = User(
  id: Uuid().v4(),
  name: 'Hieu2',
  age: 25,
  gender: Gender.male,
  isMe: false,
);
User user3 = User(
  id: Uuid().v4(),
  name: 'Hieu3',
  age: 25,
  gender: Gender.male,
  isMe: false,
);
Message message1 =
    Message(id: 1, conversationId: 0, message: 'Message1', sender: user1);
Message message2 =
    Message(id: 2, conversationId: 0, message: 'Message2', sender: user2);
Message message3 =
    Message(id: 3, conversationId: 0, message: 'Message3', sender: user3);

List<Conversation> conversations = [
  Conversation(
    id: 1,
    type: ConversationType.single,
    creator: user1,
    participants: [user1],
    messages: [message1],
  ),
  Conversation(
    id: 2,
    type: ConversationType.single,
    creator: user2,
    participants: [user2],
    messages: [message2],
  ),
  Conversation(
    id: 3,
    type: ConversationType.single,
    creator: user3,
    participants: [user3],
    messages: [message3],
  ),
];
