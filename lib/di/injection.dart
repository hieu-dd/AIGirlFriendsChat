import 'package:ai_girl_friends/data/remote_config/repository/remote_config_repository_impl.dart';
import 'package:ai_girl_friends/domain/remote_config/repository/remote_config_repository.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  getIt.registerSingletonAsync(
      () async => await SharedPreferences.getInstance());
  getIt.registerSingleton<RemoteConfigRepository>(RemoteConfigRepositoryImpl(
    sharedPreferences: await getIt.getAsync(),
    firebaseRemoteConfig: FirebaseRemoteConfig.instance,
  ));
}
