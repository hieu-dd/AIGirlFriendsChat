import 'package:ai_girl_friends/screen/chat/chat.dart';
import 'package:ai_girl_friends/screen/conversation_list/conversation_list.dart';
import 'package:ai_girl_friends/screen/home/home.dart';
import 'package:ai_girl_friends/screen/login/login.dart';
import 'package:go_router/go_router.dart';

GoRouter appRouter({required bool isLogin}) => GoRouter(
      routes: [
        GoRoute(
          path: '/',
          redirect: (context, state) {
            if (!isLogin) {
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
            builder: (context, state) => ConversationListScreen(),
            routes: [
              GoRoute(
                name: ChatScreen.direction,
                path:
                    '${ChatScreen.direction}/:${ChatScreen.argConversationId}',
                builder: (context, state) => ChatScreen(
                    conversationId:
                        int.parse(state.params[ChatScreen.argConversationId]!)),
              ),
            ]),
      ],
    );
