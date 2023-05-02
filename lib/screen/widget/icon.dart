import 'package:flutter/material.dart';

class IconContinue extends StatelessWidget {
  final double size;

  IconContinue({Key? key, this.size = 24}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.arrow_right,
      size: size,
    );
  }
}
