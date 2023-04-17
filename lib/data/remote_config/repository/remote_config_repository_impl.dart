import 'dart:convert';

import 'package:ai_girl_friends/common/failure.dart';
import 'package:ai_girl_friends/domain/remote_config/model/prompt.dart';
import 'package:ai_girl_friends/domain/remote_config/model/remote_config.dart';
import 'package:ai_girl_friends/domain/remote_config/model/system_prompt.dart';
import 'package:ai_girl_friends/domain/remote_config/repository/remote_config_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigRepositoryImpl implements RemoteConfigRepository {
  // final SharedPreferences sharedPreferences;
  final FirebaseRemoteConfig firebaseRemoteConfig;

  RemoteConfigRepositoryImpl({
    // required this.sharedPreferences,
    required this.firebaseRemoteConfig,
  });

  @override
  Future<Either<Failure, RemoteConfig>> getRemoteConfig() async {
    try {
      await firebaseRemoteConfig.fetchAndActivate();
      final List<Prompt> prompts =
          (jsonDecode(firebaseRemoteConfig.getString("prompts")) as List)
              .map((e) => Prompt.fromJson(e))
              .toList();
      final systemPrompts =
          (jsonDecode(firebaseRemoteConfig.getString("system_prompts")) as List)
              .map((e) => SystemPrompt.fromJson(e))
              .toList();
      final remoteConfig = RemoteConfig(
        userPrompt: firebaseRemoteConfig.getString("user_prompt"),
        userMessageCount: firebaseRemoteConfig.getInt("user_message_count"),
        randomRange: firebaseRemoteConfig.getInt("random_range"),
        prompts: prompts,
        systemPrompts: systemPrompts,
      );
      return Right(remoteConfig);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
