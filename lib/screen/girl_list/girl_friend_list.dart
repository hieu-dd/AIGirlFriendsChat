import 'package:ai_girl_friends/provider/conversations_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../domain/user/model/user.dart';
import '../chat/chat.dart';

class GirlFriendListScreen extends ConsumerStatefulWidget {
  static const direction = '/girl_friend_list';

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

    void _goToChat(User user, BuildContext context) async {
      final conversationId =
          await ref.read(conversationsProvider).getConversationByUser(user);
      if (conversationId == null || conversationId == 0) return;
      context.goNamed(
        ChatScreen.direction,
        params: {ChatScreen.argConversationId: conversationId.toString()},
      );
    }

    return SafeArea(
        child: Scaffold(
      body: Column(
        children: users
            .map((user) => InkWell(
                  onTap: () {
                    _goToChat(user, context);
                  },
                  child: ListTile(
                    title: Text(
                      user.name,
                      style: TextStyle(color: Color(user.mainColor)),
                    ),
                    subtitle: Text(user.bio),
                  ),
                ))
            .toList(),
      ),
    ));
  }
}

List<User> users = [
  User(
    id: '0',
    name: 'Trist',
    age: 22,
    gender: Gender.female,
    bio: 'Tattoo artist, beer lover',
    profileBio:
        "I'm a freelance tattoo artist who loves nothing more than creating custom designs for my clients. When I'm not inking, you can usually find me at a local brewery trying out the latest craft beers.",
    job: "Tattoo artist",
    profileInterests: const [
      "Drawing",
      "Beer tasting",
      "Biking",
      "Video games",
      "Music festivals",
    ],
    mainColor: 0xFFB12929,
    backgroundColor: 0xFF25080B,
  ),
  User(
    id: '1',
    name: 'Yen',
    age: 23,
    gender: Gender.female,
    bio: "Dog lover, pizza enthusiast",
    profileBio:
        "I'm a student with a passion for animals and a weakness for pizza. When I'm not studying, I volunteer at the local animal shelter and spend way too much time watching Netflix.",
    job: "Student",
    profileInterests: const [
      "Hiking",
      "Playing with dogs",
      "Reading",
      "Photography",
    ],
    mainColor: 0xFFF48FB1,
    backgroundColor: 0xFF32203A,
  ),
];
