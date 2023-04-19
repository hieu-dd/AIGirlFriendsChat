import 'package:ai_girl_friends/common/database/dao/user_dao.dart';
import 'package:ai_girl_friends/common/failure.dart';
import 'package:ai_girl_friends/domain/user/model/user.dart';
import 'package:ai_girl_friends/domain/user/repository/user_repository.dart';
import 'package:dartz/dartz.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDao userDao;

  UserRepositoryImpl(this.userDao);

  @override
  Future<Either<Failure, User>> findMe() async {
    try {
      final user = await userDao.findMe();
      return Right(user);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<void> loginWithUser(User user) async {
    try {
      await userDao.insertUser(user);
    } catch (e) {}
  }
}
