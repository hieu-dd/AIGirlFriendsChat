import 'package:ai_girl_friends/common/failure.dart';
import 'package:ai_girl_friends/di/injection.dart';
import 'package:ai_girl_friends/domain/remote_config/model/remote_config.dart';
import 'package:ai_girl_friends/domain/remote_config/repository/remote_config_repository.dart';
import 'package:dartz/dartz.dart' hide State;
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final RemoteConfigRepository _remoteConfigRepository = getIt();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<Either<Failure, RemoteConfig>>(
          future: _remoteConfigRepository.getRemoteConfig(),
          builder: (BuildContext context,
              AsyncSnapshot<Either<Failure, RemoteConfig>> snapshot) {
            return snapshot.hasData
                ? Center(
                    child: snapshot.data!.fold(
                      (l) => Text(l.message),
                      (r) => Text(r.prompts.map((e) => e.content).join(",")),
                    ),
                  )
                : Text(snapshot.error.toString());
          },
        ),
      ),
    );
  }
}
