import 'package:flutter/material.dart';

PreferredSizeWidget commonAppbar({
  required BuildContext context,
  Widget? leading,
  Widget? title,
}) {
  return AppBar(
      toolbarHeight: 80,
      backgroundColor: Theme.of(context).colorScheme.background,
      leading: leading,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Divider(
          color: Theme.of(context).colorScheme.onBackground,
          thickness: 1,
        ),
      ),
      elevation: 0,
      centerTitle: true,
      title: title);
}
