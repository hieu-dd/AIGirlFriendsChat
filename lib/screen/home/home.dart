import 'package:ai_girl_friends/di/injection.dart';
import 'package:ai_girl_friends/domain/remote_config/usecase/get_remote_config.dart';
import 'package:flutter/material.dart';

import '../../common/database/dao/user_dao.dart';
import '../../domain/user/model/user.dart';

class HomeScreen extends StatefulWidget {
  static const direction = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GetRemoteConfig _getRemoteConfig = getIt();
  final UserDao _userDao = getIt();
  User? _user;

  @override
  void initState() {
    super.initState();
    testUser();
  }

  Future<void> testUser() async {
    await _userDao.insertUser(User(
      id: "1",
      name: "Hieu",
      age: 28,
      gender: Gender.male,
    ));
    final user = await _userDao.getUserById("1");
    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(_user?.name ?? "Loading"),
      ),
    );
  }
}
