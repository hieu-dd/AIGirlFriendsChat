import 'dart:convert';

import 'package:ai_girl_friends/domain/remote_config/model/remote_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  final SharedPreferences sharedPreferences;

  SharedPreferenceHelper(this.sharedPreferences);

  void saveRemoteConfig(RemoteConfig remoteConfig) {
    sharedPreferences.setString(
        "remote_config", jsonEncode(remoteConfig.toJson()));
  }

  RemoteConfig? getRemoteConfig() {
    final configJson = sharedPreferences.getString("remote_config");
    if (configJson == null) {
      return null;
    } else {
      final remoteConfig = RemoteConfig.fromJson(jsonDecode(configJson));
      return remoteConfig;
    }
  }
}
