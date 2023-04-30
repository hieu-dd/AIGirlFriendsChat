import 'package:ai_girl_friends/ext/list_ext.dart';
import 'package:ai_girl_friends/provider/girl_firends_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../domain/user/model/user.dart';

class GirlProfileScreen extends ConsumerWidget {
  static const direction = 'girl_profile';
  static const argProfileId = 'profileId';

  final String profileId;

  GirlProfileScreen({required this.profileId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final user = ref
        .watch(girlFriendsProvider)
        .girlFriends
        .firstOrNull((girl) => girl.id == profileId);
    final backgroundColor = Color(user?.backgroundColor ?? 0);
    return user != null
        ? SafeArea(
            child: Scaffold(
              backgroundColor: backgroundColor,
              body: Stack(
                alignment: Alignment.topCenter,
                children: [
                  ..._buildBackground(user, screenWidth),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            context.pop();
                          },
                          child: const Icon(
                            Icons.chevron_left,
                            size: 32,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: screenWidth * 1.1),
                    child: _buildUserProfile(user, context),
                  )
                ],
              ),
            ),
          )
        : const Center();
  }

  List<Widget> _buildBackground(User user, double screenWidth) {
    final backgroundColor = Color(user.backgroundColor);
    return [
      Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Image.asset(
            'assets/images/yen_large_bg.png',
            fit: BoxFit.fitWidth,
          ),
        ],
      ),
      Container(
        margin: const EdgeInsets.only(top: 20),
        height: screenWidth * 1.3,
        child: Image.asset(
          user.largeBody,
          fit: BoxFit.fitHeight,
        ),
      ),
      Padding(
          padding: EdgeInsets.only(top: screenWidth),
          child: Column(
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
              Expanded(
                child: Container(
                  color: backgroundColor,
                ),
              )
            ],
          )),
    ];
  }

  Widget _buildUserProfile(User user, BuildContext context) {
    return Column(
      children: [
        Text(
          user.job,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
          ),
        ),
        Text(
          '${user.name}, ${user.age}',
          style: const TextStyle(
            inherit: false,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        _buildUserHobbies(user.profileInterests.take(3).toList(), context),
        SizedBox(
          height: 15,
        ),
        _buildUserHobbies(user.profileInterests.sublist(2, 4), context),
      ],
    );
  }

  Widget _buildUserHobbies(List<String> hobbies, BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: hobbies.mapTo(
          (hobie) => Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: EdgeInsets.symmetric(horizontal: 5),
            width: 90,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xFFD9D9D9),
            ),
            child: FittedBox(
              child: Text(
                hobie,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.background,
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ));
  }
}
