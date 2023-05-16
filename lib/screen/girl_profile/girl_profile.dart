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
    final screenHeight = MediaQuery.of(context).size.height;

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
                children: [
                  SingleChildScrollView(
                    child: Container(
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          ..._buildBackground(user, screenWidth),
                          SizedBox(
                            width: screenWidth,
                            child: _buildUserProfile(user, context),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            context.pop();
                          },
                          child: const Icon(Icons.chevron_left),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        : const Center();
  }

  List<Widget> _buildBackground(User user, double screenWidth) {
    final backgroundColor = Color(user.backgroundColor);
    return [
      Image.asset(
        'assets/images/yen_large_bg.png',
        fit: BoxFit.fitWidth,
      ),
      Container(
        margin: const EdgeInsets.only(top: 20),
        height: screenWidth * 1.3,
        child: Image.asset(
          user.largeBody,
          fit: BoxFit.fitHeight,
        ),
      ),
      Positioned(
        top: screenWidth,
        height: 75,
        width: screenWidth,
        child: Container(
          width: screenWidth,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              backgroundColor,
              Colors.transparent,
            ],
          )),
        ),
      ),
      Positioned(
        top: screenWidth + 75,
        height: screenWidth,
        width: screenWidth,
        child: Container(
          width: screenWidth,
          color: backgroundColor,
        ),
      ),
    ];
  }

  Widget _buildUserProfile(User user, BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        SizedBox(
          height: screenWidth,
        ),
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
        const SizedBox(
          height: 15,
        ),
        _buildUserHobbies(user.profileInterests.sublist(2, 4), context),
        Container(
          margin: const EdgeInsets.only(top: 35, left: 75, right: 75),
          alignment: Alignment.center,
          height: 58,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: const Color(0xFFce0011),
          ),
          child: Stack(
            children: [
              Text(
                'Chat me up',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 4
                    ..color = Colors.white,
                ),
              ),
              const Text(
                'Chat me up',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFce0011),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 34,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: 30,
            ),
            RotatedBox(
              quarterTurns: 3,
              child: Text(
                'About me'.toUpperCase(),
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Color(user.mainColor)),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
                child: Text(
              user.profileBio,
              textAlign: TextAlign.justify,
              style: const TextStyle(fontSize: 14, height: 2),
            )),
            const SizedBox(
              width: 30,
            )
          ],
        )
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
