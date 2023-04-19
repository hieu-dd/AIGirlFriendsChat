import 'package:ai_girl_friends/di/injection.dart';
import 'package:ai_girl_friends/domain/user/model/user.dart';
import 'package:ai_girl_friends/domain/user/repository/user_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthNotifier extends ChangeNotifier {
  final UserRepository repository;

  AuthNotifier(this.repository);

  User? _me;

  User? get me {
    if (_me == null) {
      _findUser();
    }
    return _me;
  }

  void _findUser() async {
    final result = await repository.findMe();
    result.fold((l) {
      _me = null;
    }, (r) {
      _me = r;
    });
    notifyListeners();
  }

  void login() async {
    await repository.login();
    _findUser();
  }
}

final authProvider = ChangeNotifierProvider<AuthNotifier>((ref) => getIt());
