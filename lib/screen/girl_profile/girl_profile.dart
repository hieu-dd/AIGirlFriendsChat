import 'package:ai_girl_friends/ext/list_ext.dart';
import 'package:ai_girl_friends/provider/girl_firends_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GirlProfileScreen extends ConsumerWidget {
  static const direction = 'girl_profile';
  static const argProfileId = 'profileId';

  final String profileId;

  GirlProfileScreen({required this.profileId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref
        .watch(girlFriendsProvider)
        .girlFriends
        .firstOrNull((girl) => girl.id == profileId);
    return user != null
        ? SafeArea(
            child: Scaffold(
              body: Stack(
                alignment: Alignment.topLeft,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Image.asset(
                        'assets/images/yen_large_bg.png',
                        fit: BoxFit.fitWidth,
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          Image.asset(
                            user.largeBody,
                            fit: BoxFit.fitWidth,
                          ),
                          Column(
                            children: [
                              Container(
                                height: 75,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    Color(user.backgroundColor),
                                    Colors.transparent,
                                  ],
                                )),
                              ),
                              Container(
                                height: 75,
                                color: Color(user.backgroundColor),
                              )
                            ],
                          )
                        ],
                      ),
                      Expanded(
                        child: Container(
                          color: Color(user.backgroundColor),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 1000,
                    child: Column(
                      children: [],
                    ),
                  )
                ],
              ),
            ),
          )
        : const Center();
  }
}
