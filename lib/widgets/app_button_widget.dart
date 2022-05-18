import 'package:flutter/material.dart';
import 'package:jobtrackeremployee/constants/app_colors.dart';

class AppButtonWidget extends StatelessWidget {
  AppButtonWidget(
      {this.title,
      this.titleColor = Colors.white,
      this.minWidth = double.infinity,
      this.backgroundColor = AppColors.appColor,
      this.textStyle,
      this.borderRadius,
      @required this.onPressed,});

  String? title;
  void Function()? onPressed;
  Color? backgroundColor = AppColors.appColor;
  Color? titleColor = Colors.white;
  double? minWidth = double.infinity;
  TextStyle? textStyle;
  BorderRadiusGeometry? borderRadius = BorderRadius.circular(29);
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.symmetric(vertical: 10),
      color: backgroundColor,
      minWidth: minWidth,
      shape: RoundedRectangleBorder(borderRadius: borderRadius!),
      onPressed: onPressed,
      child: Text("$title",
          style: textStyle,
          textAlign: TextAlign.center),
    );
  }
}
