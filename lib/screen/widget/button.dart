import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  Function onClick;
  Color? color;
  String? title;
  Gradient? gradient;
  Widget? trailing;

  PrimaryButton({
    Key? key,
    required this.onClick,
    this.color,
    this.gradient,
    this.trailing,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onClick();
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 47,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: gradient,
          color: color,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              width: 24,
            ),
            if (title != null) Text(title!),
            trailing ?? const SizedBox(width: 24),
          ],
        ),
      ),
    );
  }
}
