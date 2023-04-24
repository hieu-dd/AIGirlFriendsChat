import 'package:ai_girl_friends/screen/chat/chat.dart';
import 'package:ai_girl_friends/screen/conversation_list/conversation_list.dart';
import 'package:ai_girl_friends/screen/login/login.dart';
import 'package:go_router/go_router.dart';

GoRouter appRouter({required bool isLogin}) => GoRouter(
      routes: [
        GoRoute(
          path: '/',
          redirect: (context, state) {
            if (!isLogin) {
              return "/login";
            }
            return "/main";
          },
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => LoginScreen(),
        ),
        GoRoute(
            path: '/main',
            builder: (context, state) => ConversationListScreen(),
            routes: [
              GoRoute(
                name: 'chat',
                path: 'chat/:conversationId',
                builder: (context, state) => ChatScreen(
                    conversationId: int.parse(state.params['conversationId']!)),
              ),
            ]),
      ],
    );
