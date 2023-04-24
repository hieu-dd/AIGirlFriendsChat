import 'package:ai_girl_friends/screen/chat/chat.dart';
import 'package:ai_girl_friends/screen/login/login.dart';
import 'package:go_router/go_router.dart';

GoRouter appRouter({required bool isLogin}) => GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => ChatScreen(conversationId: 1),
          redirect: (context, state) {
            if (!isLogin) {
              return "/login";
            }
            return "/";
          },
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => LoginScreen(),
        ),
      ],
    );
