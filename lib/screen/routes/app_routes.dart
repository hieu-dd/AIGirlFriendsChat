import 'package:ai_girl_friends/provider/auth_provider.dart';
import 'package:ai_girl_friends/screen/chat/chat.dart';
import 'package:ai_girl_friends/screen/girl_profile/girl_profile.dart';
import 'package:ai_girl_friends/screen/home/home.dart';
import 'package:ai_girl_friends/screen/login/login.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final isLoggedIn = ref.watch(authProvider).me != null;
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        redirect: (context, state) {
          if (!isLoggedIn) {
            return LoginScreen.direction;
          }
          return HomeScreen.direction;
        },
      ),
      GoRoute(
        path: LoginScreen.direction,
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
          path: HomeScreen.direction,
          builder: (context, state) => HomeScreen(),
          routes: [
            GoRoute(
              name: ChatScreen.direction,
              path: '${ChatScreen.direction}/:${ChatScreen.argConversationId}',
              builder: (context, state) => ChatScreen(
                  conversationId:
                      int.parse(state.params[ChatScreen.argConversationId]!)),
            ),
            GoRoute(
                name: GirlProfileScreen.direction,
                path:
                    '${GirlProfileScreen.direction}/:${GirlProfileScreen.argProfileId}',
                builder: (context, state) => GirlProfileScreen(
                      profileId:
                          state.params[GirlProfileScreen.argProfileId] ?? "",
                    )),
          ]),
    ],
  );
});
