import 'package:ai_girl_friends/common/database/dao/conversation_dao.dart';
import 'package:ai_girl_friends/common/database/dao/message_dao.dart';
import 'package:ai_girl_friends/common/database/dao/participant_dao.dart';
import 'package:ai_girl_friends/common/database/dao/user_dao.dart';
import 'package:ai_girl_friends/common/shared_preferences/shared_preference_helper.dart';
import 'package:ai_girl_friends/data/conversation/repository/conversation_repository_impl.dart';
import 'package:ai_girl_friends/data/remote_config/repository/remote_config_repository_impl.dart';
import 'package:ai_girl_friends/domain/conversation/repository/conversation_repository.dart';
import 'package:ai_girl_friends/domain/remote_config/repository/remote_config_repository.dart';
import 'package:ai_girl_friends/domain/remote_config/usecase/get_remote_config.dart';
import 'package:ai_girl_friends/domain/user/data/repository/user_repository_impl.dart';
import 'package:ai_girl_friends/domain/user/repository/user_repository.dart';
import 'package:ai_girl_friends/provider/auth_provider.dart';
import 'package:ai_girl_friends/provider/conversation_provider.dart';
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
  getIt.registerFactory(() => UserDao());
  getIt.registerFactory(() => ConversationDao());
  getIt.registerFactory(() => MessageDao());
  getIt.registerFactory(() => ParticipantDao());
  getIt.registerFactory<ConversationRepository>(
    () => ConversationRepositoryImpl(
      conversationDao: getIt(),
      participantDao: getIt(),
      messageDao: getIt(),
      userDao: getIt(),
    ),
  );
  getIt.registerSingleton<UserRepository>(UserRepositoryImpl(getIt()));
  getIt.registerSingleton(AuthNotifier(getIt()));
  getIt.registerSingleton(ConversationNotifier(getIt()));
}
