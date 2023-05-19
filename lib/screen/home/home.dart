import 'package:ai_girl_friends/screen/conversation_list/conversation_list.dart';
import 'package:ai_girl_friends/screen/girl_list/girl_friend_list.dart';
import 'package:ai_girl_friends/screen/premium/premium.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  static const direction = '/home';

  HomeScreen();

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 1;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Center(),
    GirlFriendListScreen(),
    ConversationListScreen(),
  ];

  void _onItemTapped(int index, BuildContext context) {
    if (index != 0) {
      setState(() {
        _selectedIndex = index;
      });
    } else {
      context.goNamed(PremiumScreen.direction);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: Container(
          color: Theme.of(context).colorScheme.background,
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 9),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(60),
            child: SizedBox(
              height: 60,
              child: BottomNavigationBar(
                showSelectedLabels: false,
                showUnselectedLabels: false,
                selectedFontSize: 0,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: SizedBox(
                        width: 46,
                        height: 46,
                        child: Image.asset('assets/images/crown.png')),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: SizedBox(
                        height: 44,
                        width: 42,
                        child: Image.asset('assets/images/heart.png')),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: SizedBox(
                        width: 44,
                        height: 36,
                        child: Image.asset('assets/images/setting.png')),
                    label: '',
                  ),
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: Colors.amber[800],
                onTap: (index) {
                  _onItemTapped(index, context);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
