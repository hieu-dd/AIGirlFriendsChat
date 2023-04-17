import 'package:ai_girl_friends/common/shared_preferences/shared_preference_helper.dart';
import 'package:ai_girl_friends/data/remote_config/repository/remote_config_repository_impl.dart';
import 'package:ai_girl_friends/domain/remote_config/repository/remote_config_repository.dart';
import 'package:ai_girl_friends/domain/remote_config/usecase/get_remote_config.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  getIt.registerSingletonAsync(
      () async => await SharedPreferences.getInstance());
  getIt.registerSingleton(SharedPreferenceHelper(await getIt.getAsync()));
  getIt.registerSingleton<RemoteConfigRepository>(RemoteConfigRepositoryImpl(
    sharedPreferenceHelper: getIt(),
    firebaseRemoteConfig: FirebaseRemoteConfig.instance,
  ));
  getIt.registerFactory(() => GetRemoteConfig(repository: getIt()));
}
