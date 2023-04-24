import 'package:ai_girl_friends/provider/conversations_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../domain/user/model/user.dart';
import '../chat/chat.dart';

class GirlFriendListScreen extends ConsumerStatefulWidget {
  const GirlFriendListScreen({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _GirlFriendListScreenState();
}

class _GirlFriendListScreenState extends ConsumerState<GirlFriendListScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(), () {
      ref.read(conversationsProvider).createSingleConversations(users);
    });
  }

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

List<User> users = [
  User(
    id: 'yen',
    name: 'yen',
    age: 25,
    gender: Gender.male,
  ),
  User(
    id: 'trang',
    name: 'trang',
    age: 25,
    gender: Gender.male,
  ),
];
