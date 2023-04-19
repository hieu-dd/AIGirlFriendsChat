import 'package:ai_girl_friends/screen/conversation_list/conversation_list.dart';
import 'package:ai_girl_friends/screen/login/login.dart';
import 'package:go_router/go_router.dart';

GoRouter appRouter({required bool isLogin}) => GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => ConversationListScreen(),
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
