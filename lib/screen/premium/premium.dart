import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PremiumScreen extends ConsumerWidget {
  static const direction = 'premium';

  const PremiumScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Text("Premium"),
      ),
    ));
  }
}
