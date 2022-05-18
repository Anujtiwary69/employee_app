import 'package:flutter/material.dart';
import 'package:jobtrackeremployee/constants/app_colors.dart';
import 'package:jobtrackeremployee/constants/app_dimens.dart';

class AppTextFormFieldWidget extends StatelessWidget {
  AppTextFormFieldWidget(
      {Key? key,
      this.controller,
      this.headerText,
      this.text,
      this.maxLines,
      this.onChanged,
      this.isFilled = false,
      this.obscure = false,
      this.filledColor,
      this.isIconVisibile = false,
      this.passwordEyeIcon,
      this.borderColor,
      this.onPassIconTap,
      this.prefixIcon,
      this.isOutlineBorder = false,
      this.hintTextStyle = const TextStyle(color: Colors.black38, fontSize: 22),
      this.textStyle = const TextStyle(color: Colors.black87, fontSize: 22),
      this.keyBoardType})
      : super(key: key);

  TextEditingController? controller;
  String? text = "";
  String? headerText = "";
  int? maxLines = 1;
  bool? obscure = false;
  Color? filledColor = AppColors.appColor.withOpacity(0.2);
  bool isFilled = false;
  Color? borderColor;
  IconData? prefixIcon;
  bool? isOutlineBorder = false;

  TextInputType? keyBoardType = TextInputType.text;
  bool? isIconVisibile = false;
  IconData? passwordEyeIcon;
  AppDimens? appDimens;
  TextStyle? hintTextStyle, textStyle;
  void Function()? onPassIconTap;
  void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    appDimens = AppDimens(MediaQuery.of(context).size.width);
    return Material(
      child: TextFormField(
        obscureText: obscure!,
        onChanged: onChanged,
        controller: controller,
        cursorColor: Colors.black,
        cursorWidth: 1,
        maxLines: maxLines,
        style: textStyle,
        keyboardType: keyBoardType,
        decoration: InputDecoration(
          suffixIcon: Visibility(
            visible: isIconVisibile!,
            child: InkWell(
              onTap: onPassIconTap,
              child: Icon(
                passwordEyeIcon,
                size: appDimens!.textw18,
                // color: type == LoginType.caregiver
                //     ? AppColors.appColor
                //     : AppColors.pinkButtonColor,
              ),
            ),
          ),
          hintText: text,
          hintStyle: hintTextStyle,
          fillColor: filledColor,
          filled: isFilled,
          prefixIcon: Icon(
            prefixIcon,
            size: appDimens!.textw18,
            color: AppColors.appColor,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          border: isOutlineBorder!
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: borderColor!))
              : UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 3,
                  )),
          focusedBorder: isOutlineBorder!
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: borderColor!))
              : UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: borderColor!, width: 3)),
          disabledBorder: isOutlineBorder!
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: borderColor!))
              : UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.grey, width: 3)),
          enabledBorder: isOutlineBorder!
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: borderColor!))
              : UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: borderColor!, width: 3)),
        ),
      ),
    );
  }
}
