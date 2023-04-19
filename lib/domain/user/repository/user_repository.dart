import 'package:ai_girl_friends/common/failure.dart';
import 'package:dartz/dartz.dart';

import '../model/user.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> findMe();
  Future<void> login();
}
