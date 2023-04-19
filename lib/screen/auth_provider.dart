import 'package:ai_girl_friends/di/injection.dart';
import 'package:ai_girl_friends/domain/user/model/user.dart';
import 'package:ai_girl_friends/domain/user/repository/user_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

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
      if (_me != null) {
        _me = null;
        notifyListeners();
      }
    }, (r) {
      _me = r;
      notifyListeners();
    });
  }

  void loginWithUser(
      {required String name,
      required int age,
      required String genderValue}) async {
    final gender =
        Gender.values.firstWhere((element) => element.name == genderValue);
    await repository.loginWithUser(
        User(id: Uuid().v4(), name: name, age: age, gender: gender));
    _findUser();
  }
}

final authProvider = ChangeNotifierProvider<AuthNotifier>((ref) => getIt());
