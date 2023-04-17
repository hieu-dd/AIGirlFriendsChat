import 'package:ai_girl_friends/common/failure.dart';
import 'package:ai_girl_friends/di/injection.dart';
import 'package:ai_girl_friends/domain/remote_config/model/remote_config.dart';
import 'package:ai_girl_friends/domain/remote_config/usecase/get_remote_config.dart';
import 'package:dartz/dartz.dart' hide State;
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GetRemoteConfig _getRemoteConfig = getIt();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<Either<Failure, RemoteConfig>>(
          future: _getRemoteConfig(),
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
