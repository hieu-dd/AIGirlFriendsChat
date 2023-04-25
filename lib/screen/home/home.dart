import 'package:ai_girl_friends/screen/conversation_list/conversation_list.dart';
import 'package:ai_girl_friends/screen/girl_list/girl_friend_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  static const direction = '/home';
  final Widget child;

  HomeScreen({required this.child});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Billion Dollar App')),
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _calculateSelectedIndex(context),
        onTap: onTap,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box), label: 'Account'),
        ],
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final GoRouter route = GoRouter.of(context);
    final String location = route.location;
    if (location.startsWith(GirlFriendListScreen.direction)) {
      return 0;
    }
    if (location.startsWith(ConversationListScreen.direction)) {
      return 1;
    }
    return 0;
  }

  void onTap(int value) {
    switch (value) {
      case 0:
        return context.go(GirlFriendListScreen.direction);
      case 1:
        return context.go(ConversationListScreen.direction);
      default:
        return context.go(GirlFriendListScreen.direction);
    }
  }
}
