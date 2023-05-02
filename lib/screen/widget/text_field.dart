import 'package:flutter/material.dart';

class RoundedTextField extends StatelessWidget {
  TextEditingController? textEditingController;
  Widget? trailing;
  EdgeInsetsGeometry? margin;
  EdgeInsetsGeometry? padding;
  Color? background;
  double height;
  String? hintText;

  RoundedTextField({
    Key? key,
    this.textEditingController,
    this.trailing,
    this.margin,
    this.padding,
    this.background,
    this.height = 50,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60),
        border: Border.all(
            width: 1, color: Theme.of(context).colorScheme.onBackground),
        color: background,
      ),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            key: key,
            decoration:
                InputDecoration(border: InputBorder.none, hintText: hintText),
            controller: textEditingController,
          )),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
