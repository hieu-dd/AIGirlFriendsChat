import 'package:ai_girl_friends/ext/list_ext.dart';
import 'package:ai_girl_friends/provider/conversations_provider.dart';
import 'package:ai_girl_friends/provider/girl_firends_provider.dart';
import 'package:ai_girl_friends/screen/girl_profile/girl_profile.dart';
import 'package:ai_girl_friends/screen/girl_profile/unlock_profile.dart';
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
    Future.delayed(const Duration(), () async {
      final users = await ref.read(girlFriendsProvider).fetchGirlFriends();
      ref.read(conversationsProvider).createSingleConversations(users);
    });
  }

  @override
  Widget build(BuildContext context) {
    final girlFriends = ref.watch(girlFriendsProvider).girlFriends;
    void _goToChat(User user, BuildContext context) async {
      final conversationId =
          await ref.read(conversationsProvider).getConversationByUser(user);
      if (conversationId == null || conversationId == 0) return;
      context.goNamed(
        ChatScreen.direction,
        params: {ChatScreen.argConversationId: conversationId.toString()},
      );
    }

    void _goToProfile(User user, BuildContext context) {
      context.goNamed(
        GirlProfileScreen.direction,
        params: {GirlProfileScreen.argProfileId: user.id},
      );
    }

    void _unlock(User user) {
      context.goNamed(
        UnlockProfileScreen.direction,
        params: {UnlockProfileScreen.argProfileId: user.id},
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
                scrollBehavior: ScrollBehavior(),
                children: girlFriends.mapTo((user) => _userProfileItem(
                      user,
                      context: context,
                      gotoChat: _goToChat,
                      gotoProfile: _goToProfile,
                      unlock: _unlock,
                    )),
              ),
            ),
            const SizedBox(
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
  Function? unlock,
  required BuildContext context,
}) {
  final typography = Theme.of(context).typography;
  final colorScheme = Theme.of(context).colorScheme;
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 5),
    child: SizedBox(
      height: double.infinity,
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          if (!user.enable)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 29,
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                child: Container(
                  color: Colors.yellow,
                  child: FractionallySizedBox(
                    heightFactor: 0.95,
                    child: Container(),
                  ),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 1,
              top: 1,
            ),
            child: FractionallySizedBox(
              heightFactor: 1,
              child: Image.asset(
                user.largeBody,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 30, right: 30, bottom: 1, top: 1),
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
          Container(
            width: double.infinity,
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
                user.enable
                    ? Text(
                        user.profileBio,
                        style: const TextStyle(
                            fontSize: 12,
                            inherit: false,
                            fontWeight: FontWeight.normal),
                      )
                    : const SizedBox(
                        height: 50,
                      ),
                const SizedBox(height: 40),
                user.enable
                    ? Row(
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
                      )
                    : InkWell(
                        onTap: () {
                          unlock?.call(user);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Text("Unlock ${user.name}"),
                            )
                          ],
                        ),
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
