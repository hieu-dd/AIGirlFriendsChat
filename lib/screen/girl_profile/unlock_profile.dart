import 'package:ai_girl_friends/ext/list_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../provider/girl_firends_provider.dart';

class UnlockProfileScreen extends ConsumerWidget {
  static const direction = 'unlock_profile';
  static const argProfileId = 'profileId';

  final String profileId;

  const UnlockProfileScreen({Key? key, required this.profileId})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref
        .watch(girlFriendsProvider)
        .girlFriends
        .firstOrNull((girl) => girl.id == profileId);
    return user != null
        ? Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            body: SafeArea(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Positioned(
                    left: 0,
                    bottom: 200,
                    right: 0,
                    top: 200,
                    child: CustomPaint(
                      painter: TrianglePainter(const LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        stops: [0.0, 0.7, 1.0],
                        colors: [
                          Color(0xFFFFD682),
                          Color(0xCFFFD682),
                          Color(0x9FFFD682),
                        ],
                      )),
                    ),
                  ),
                  Container(
                    height: 200,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        stops: [0.0, 0.5, 1.0],
                        colors: [
                          Color(0xFFFFC452),
                          Color(0xFFFFD052),
                          Color(0xFFFFD682)
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 100,
                    left: 0,
                    right: 0,
                    top: 10,
                    child: Image.asset(
                      user.unlockBackground,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Positioned(
                    bottom: 100,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 100,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Color(0xFFFFD052),
                            Color(0x3FFFD052),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    bottom: 200,
                    right: 0,
                    top: 200,
                    child: CustomPaint(
                      painter: TrianglePainter(const LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        stops: [0.0, 0.1, 0.2, 0.3, 1.0],
                        colors: [
                          Color(0x3FFFD052),
                          Color(0x1FFFD052),
                          Color(0x09FFD052),
                          Colors.transparent,
                          Colors.transparent
                        ],
                      )),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Unlock for",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            height: 0),
                      ),
                      const Text(
                        "\$22.99",
                        style: TextStyle(
                          fontSize: 50,
                          height: 0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "Passionate about exploring the world one coffee shop at a time. I can cook for you everyday *wink.",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                            height: 42,
                            width: 200,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Color(0xFF00BA99),
                                  Color(0xFF00BA99)
                                ]),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(42))),
                            child: const Text(
                              "Get now",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                              ),
                            )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                  Positioned(
                    left: 30,
                    top: 50,
                    child: Column(
                      children: user.name.characters.mapTo((e) => Text(
                            e.toUpperCase(),
                            style: const TextStyle(
                                fontSize: 42,
                                fontWeight: FontWeight.bold,
                                height: 1.3),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Center();
  }
}

class TrianglePainter extends CustomPainter {
  LinearGradient gradient;

  TrianglePainter(this.gradient);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    paint.shader =
        gradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    paint.style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) => false;
}
