import 'package:flutter/material.dart';

class IconContinue extends StatelessWidget {
  final double size;

  IconContinue({Key? key, this.size = 24}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/ic_continue.png',
      width: size,
      height: size,
    );
  }
}

class IconBack extends StatelessWidget {
  final double size;

  IconBack({Key? key, this.size = 24}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/ic_back.png',
      width: size,
      height: size,
    );
  }
}
