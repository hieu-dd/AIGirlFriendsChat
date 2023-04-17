import 'package:ai_girl_friends/common/failure.dart';
import 'package:ai_girl_friends/domain/remote_config/model/remote_config.dart';
import 'package:dartz/dartz.dart';

abstract class RemoteConfigRepository {
  Future<Either<Failure, RemoteConfig>> getRemoteConfig();
}
