import 'package:flutter/material.dart';
import 'package:flutter_todo_list/misc/constants.dart';
import 'package:get/get.dart';

class GenericAppBar extends StatelessWidget with PreferredSizeWidget {
  const GenericAppBar({
    Key? key,
    this.actions,
    this.title,
    this.backButtonAsset = Icons.chevron_left,
    this.shouldNotGoBack = false,
    this.bottom,
    this.preferredHeight = 48,
    this.topPadding,
    this.onBackButtonPressed,
    this.backgroundColor = kYellowFEBD23,
  }) : super(key: key);

  final List<Widget>? actions;
  final String? title;
  final IconData backButtonAsset;
  final bool shouldNotGoBack;
  final PreferredSizeWidget? bottom;
  final double preferredHeight;
  final double? topPadding;
  final VoidCallback? onBackButtonPressed;
  final Color backgroundColor;

  @override
  Size get preferredSize => Size.fromHeight(preferredHeight);

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).viewPadding.top;
    return Padding(
      padding: EdgeInsets.only(top: 0),
      child: AppBar(
          actions: actions,
          leading: Navigator.of(context).canPop() && !shouldNotGoBack
              ? IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    if (onBackButtonPressed != null) {
                      onBackButtonPressed!();
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
                  icon: Icon(backButtonAsset))
              : null,
          toolbarHeight: preferredHeight,
          elevation: 0,
          backgroundColor: backgroundColor,
          centerTitle: false,
          title: Text(title ?? '',
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
          bottom: bottom),
    );
  }
}