import 'package:ai_girl_friends/screen/conversation_list/conversation_list.dart';
import 'package:ai_girl_friends/screen/girl_list/girl_friend_list.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const direction = '/home';

  HomeScreen();

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    GirlFriendListScreen(),
    ConversationListScreen(),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
                onTap: _onItemTapped,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
