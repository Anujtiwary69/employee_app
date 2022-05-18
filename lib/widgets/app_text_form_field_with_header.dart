import 'package:flutter/material.dart';
import 'package:jobtrackeremployee/constants/app_colors.dart';

class TextFormFieldWidgetWithHeader extends StatelessWidget {
  TextFormFieldWidgetWithHeader(
      {Key? key,
      this.controller,
      this.headerText,
      this.text,
      this.maxLines,
      this.focusNode,
      this.onTap,
      this.isOutlineBorder = true,
      this.keyBoardType})
      : super(key: key);

  TextEditingController? controller;
  String? text = "";
  FocusNode? focusNode;
  bool? isOutlineBorder = false;
  void Function()? onTap;

  String? headerText = "";
  int? maxLines = 1;
  TextInputType? keyBoardType = TextInputType.text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: headerText == null ? false : true,
            child: Text(
              "${headerText ?? ""}",
              style: TextStyle(
                fontSize: 20,
                color: AppColors.appColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            // height: 40,
            child: TextFormField(
              onTap: onTap,
              focusNode: focusNode,
              controller: controller,
              cursorColor: Colors.black,
              cursorWidth: 1,
              maxLines: maxLines,
              keyboardType: keyBoardType,
              style: TextStyle(color: Colors.black87, fontSize: 18),
              decoration: InputDecoration(
                hintText: text,
                fillColor: AppColors.appColor.withOpacity(0.1),
                filled: true,
                labelStyle: TextStyle(color: AppColors.appColor),
                hintStyle: TextStyle(
                    color: AppColors.appColor,
                    fontStyle: FontStyle.italic,
                    fontSize: 18),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                border: isOutlineBorder!
                    ? OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: AppColors.appColor))
                    : UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                        borderSide: BorderSide(
                          color: AppColors.appColor,
                          width: 3,
                        )),
                focusedBorder: isOutlineBorder!
                    ? OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: AppColors.appColor))
                    : UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                        borderSide:
                            BorderSide(color: AppColors.appColor, width: 3)),
                disabledBorder: isOutlineBorder!
                    ? OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: AppColors.appColor))
                    : UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                        borderSide:
                            BorderSide(color: AppColors.appColor, width: 3)),
                enabledBorder: isOutlineBorder!
                    ? OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: AppColors.appColor))
                    : UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                        borderSide:
                            BorderSide(color: AppColors.appColor, width: 3)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
