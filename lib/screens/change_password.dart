import 'package:flutter/material.dart';
import 'package:jobtrackeremployee/constants/app_colors.dart';
import 'package:jobtrackeremployee/constants/app_constants.dart';
import 'package:jobtrackeremployee/constants/app_dimens.dart';
import 'package:jobtrackeremployee/widgets/app_bar_widget.dart';
import 'package:jobtrackeremployee/widgets/app_button_widget.dart';
import 'package:jobtrackeremployee/widgets/app_text_form_field_with_header.dart';

class ChangePassword extends StatelessWidget {
  AppDimens? appDimens;

  @override
  Widget build(BuildContext context) {
    appDimens = AppDimens(MediaQuery.of(context).size.width);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 56),
        child: AppBarWidget(
          automaticImplyLeading: true,
          iconThemeData: IconThemeData(color: Colors.black),

          // leading: Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Image.asset(
          //     "assets/logo/logo2.png",
          //     height: 41,
          //     width: 41,
          //   ),
          // ),
          // text: "Account",
          title: Text(
            "Change Password",
            style:
                TextStyle(color: Colors.black87, fontSize: appDimens!.textw20),
          ),
        ),
      ),
      body: _buildBody(),
    );
  }

  TextEditingController oldPass = TextEditingController();
  TextEditingController newPass = TextEditingController();
  TextEditingController confirmPass = TextEditingController();
  _buildBody() {
    return Container(
      child: Column(
        children: [
          _textFormFild("Old Password", "Enter old password", oldPass),
          _textFormFild("New Password", "Enter new password", newPass),
          _textFormFild("Old Password", "Enter confirm password", confirmPass),
          _bottomButton()
        ],
      ),
    );
  }

  _bottomButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 80, 15, 0),
      child: AppButtonWidget(
        onPressed: () {
          _validation();
        },
        title: "Submit",
        borderRadius: BorderRadius.circular(10),
        backgroundColor: AppColors.appColor,
        textStyle: TextStyle(color: Colors.white, fontSize: appDimens!.textw22),
      ),
    );
  }

  _textFormFild(
      String headerText, String hintText, TextEditingController controller) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: TextFormFieldWidgetWithHeader(
        headerText: headerText,
        text: hintText,
        controller: controller,
      ),
    );
  }

  _validation() {
    if (oldPass.text.trim().length == 0) {
      AppConstants().showToast(
          msg: "Please enter old password", fontSize: appDimens!.textw16);
    } else if (newPass.text.trim().length == 0) {
      AppConstants().showToast(
          msg: "Please enter new password", fontSize: appDimens!.textw16);
    } else if (confirmPass.text.trim().length == 0) {
      AppConstants().showToast(
          msg: "Please enter confirm password", fontSize: appDimens!.textw16);
    } else if (newPass.text.trim() != confirmPass.text.trim())
      AppConstants().showToast(
          msg: "Confirm password and new password does not match",
          fontSize: appDimens!.textw16);
  }
}
