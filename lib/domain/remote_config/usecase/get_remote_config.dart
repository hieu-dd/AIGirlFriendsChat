import 'package:ai_girl_friends/common/failure.dart';
import 'package:ai_girl_friends/domain/remote_config/model/remote_config.dart';
import 'package:ai_girl_friends/domain/remote_config/repository/remote_config_repository.dart';
import 'package:dartz/dartz.dart';

class GetRemoteConfig {
  final RemoteConfigRepository repository;

  GetRemoteConfig({required this.repository});

  Future<Either<Failure, RemoteConfig>> call() async {
    return repository.getRemoteConfig();
  }
}
