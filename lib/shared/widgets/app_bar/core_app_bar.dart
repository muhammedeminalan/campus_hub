import 'package:flutter/material.dart';
import 'package:wonzy_core_utils/wonzy_core_utils.dart';

class CoreAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CoreAppBar({super.key, this.title, this.actions, this.leading});
  final String? title;
  final List<Widget>? actions;
  final Widget? leading;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Wonzy.appBar(title: title, actions: actions, leading: leading);
  }
}
