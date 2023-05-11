import 'package:flutter/material.dart';

class LoadingIndicator extends StatefulWidget {
  final int dotCount;
  final Duration dotDuration;

  LoadingIndicator(
      {this.dotCount = 3,
      this.dotDuration = const Duration(milliseconds: 500)});

  @override
  _LoadingIndicatorState createState() => _LoadingIndicatorState();
}

class _LoadingIndicatorState extends State<LoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  int _dotIndex = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.dotDuration * widget.dotCount,
    )
      ..addListener(() {
        setState(() {
          _dotIndex =
              (_animationController.value * (widget.dotCount + 1)).floor();
        });
      })
      ..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.dotCount, (index) {
        return Text(
          _dotIndex >= index ? "." : "",
          style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
            color: Colors.grey[600],
          ),
        );
      }),
    );
  }
}
