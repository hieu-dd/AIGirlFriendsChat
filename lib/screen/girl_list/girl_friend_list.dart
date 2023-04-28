import 'package:ai_girl_friends/ext/Collection.dart';
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

    final user = users[0];
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text("App name"),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: PageView(
                children: users.mapTo((user) => _userProfileItem(
                    user: user,
                    onClick: () {
                      _goToChat(user, context);
                    })),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget _userProfileItem({
  required User user,
  Function? onClick,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 5),
    child: SizedBox(
      height: double.infinity,
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          FractionallySizedBox(
            heightFactor: 1,
            child: Image.asset(
              user.largeBody,
              fit: BoxFit.fitHeight,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
              child: FractionallySizedBox(
                heightFactor: 0.95,
                child: Image.asset(
                  user.largeBodyBlurCutOff,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: TextStyle(color: Colors.white),
                ),
                Text(user.job),
              ],
            ),
          )
        ],
      ),
    ),
  );
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
    largeBody: 'assets/images/trist.png',
    largeBodyBlurCutOff: 'assets/images/trist_bg.png',
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
    largeBody: 'assets/images/yen.png',
    largeBodyBlurCutOff: 'assets/images/yen_bg.png',
  ),
];
