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

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              "App name",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: PageView(
                children: users.mapTo((user) => _userProfileItem(user,
                    context: context, gotoChat: _goToChat)),
              ),
            ),
            SizedBox(
              height: 45,
            )
          ],
        ),
      ),
    );
  }
}

Widget _userProfileItem(
  User user, {
  Function? gotoChat,
  Function? gotoProfile,
  required BuildContext context,
}) {
  final typography = Theme.of(context).typography;
  final colorScheme = Theme.of(context).colorScheme;
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
                  textScaleFactor: 1.0,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    inherit: false,
                  ),
                ),
                Text(
                  user.job,
                  style: const TextStyle(
                      fontSize: 12,
                      inherit: false,
                      fontWeight: FontWeight.normal),
                ),
                Text(
                  user.profileBio,
                  style: const TextStyle(
                      fontSize: 12,
                      inherit: false,
                      fontWeight: FontWeight.normal),
                ),
                const SizedBox(height: 45),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        onPressed: () {
                          gotoProfile?.call(user, context);
                        },
                        icon: const Icon(
                          Icons.account_box_outlined,
                          size: 36,
                        )),
                    Container(
                      width: 2,
                      height: 24,
                      color: colorScheme.onBackground,
                    ),
                    IconButton(
                        onPressed: () {
                          gotoChat?.call(user, context);
                        },
                        icon: const Icon(
                          Icons.chat_bubble_outline,
                          size: 36,
                        )),
                  ],
                ),
                const SizedBox(height: 18)
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
