import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  AppBarWidget({
    this.text,
    this.actions,
    this.iconThemeData,
    this.title,
    this.flexibleSpace,
    this.bottom,
    this.elevation,
    this.shadowColor,
    this.automaticImplyLeading = false,
    this.shape,
    this.backgroundColor,
    this.actionsIconTheme,
    this.leading,
    this.preferredSize = const Size.fromHeight(kToolbarHeight + (0.0)),
  });
  Size preferredSize;
  List<Widget>? actions;
  Widget? title;
  Widget? leading;

  Widget? flexibleSpace;

  PreferredSizeWidget? bottom;

  double? elevation;
  IconThemeData? actionsIconTheme, iconThemeData;

  Color? shadowColor;

  ShapeBorder? shape;

  Color? backgroundColor;
  String? text;
  bool? automaticImplyLeading = false;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: actions,
      title: title,
      automaticallyImplyLeading: automaticImplyLeading!,
      actionsIconTheme: actionsIconTheme,
      iconTheme: iconThemeData,
      leading: leading,
      flexibleSpace: flexibleSpace,
      elevation: elevation,
      shadowColor: shadowColor,
      shape: shape,
      backgroundColor: Colors.white,
    );
  }
}
