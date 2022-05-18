import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jobtrackeremployee/constants/app_colors.dart';
import 'package:jobtrackeremployee/constants/app_constants.dart';
import 'package:jobtrackeremployee/constants/app_dimens.dart';
import 'package:jobtrackeremployee/constants/app_strings.dart';
import 'package:jobtrackeremployee/models/job_detail_model.dart';
import 'package:jobtrackeremployee/models/login_model.dart';
import 'package:jobtrackeremployee/providers/login_provider.dart';
import 'package:jobtrackeremployee/screens/bottom_navigation_bar.dart';
import 'package:jobtrackeremployee/screens/home_screen.dart';
import 'package:jobtrackeremployee/utilities/shared_pref.dart';
import 'package:jobtrackeremployee/widgets/app_button_widget.dart';
import 'package:jobtrackeremployee/widgets/app_text_field_widget.dart';

import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AppDimens? appDimens;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setData();
  }

  void setData() {
    emailController.text = "katie@gmail.com";
    passController.text = "katie@123";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var providerData = Provider.of<LoginProvider>(context);
    appDimens = AppDimens(MediaQuery.of(context).size.width);
    return Stack(
      children: [
        Material(
          child: InkWell(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Scaffold(
              body: _mainBody(),
            ),
          ),
        ),
        AppConstants.progress(isLoading, context)
      ],
    );
  }

  TextEditingController emailController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController passController = new TextEditingController();

  _mainBody() {
    return Consumer<LoginProvider>(
      builder: (_, model, __) {
        return Container(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.1),
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Login",
                      style: TextStyle(
                          color: const Color(0xff4681c3),
                          fontWeight: FontWeight.w800,
                          fontFamily: "Poppins",
                          fontStyle: FontStyle.normal,
                          fontSize: appDimens!.textw40),
                      textAlign: TextAlign.center),
                  SizedBox(height: 60),
                  AppTextFormFieldWidget(
                    obscure: false,
                    maxLines: 1,

                    // hintTextStyle: Text,
                    borderColor: AppColors.appColor,
                    filledColor: AppColors.appColor.withOpacity(0.2),
                    controller: emailController,
                    prefixIcon: Icons.email,
                    keyBoardType: TextInputType.emailAddress,
                    text: "Email",
                    hintTextStyle: TextStyle(
                        color: AppColors.appColor,
                        fontWeight: FontWeight.w300,
                        fontFamily: "Poppins",
                        fontStyle: FontStyle.normal,
                        fontSize: appDimens!.textw16),
                    textStyle: TextStyle(
                        color: AppColors.appColor,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Poppins",
                        fontStyle: FontStyle.normal,
                        fontSize: appDimens!.textw16),
                  ),
                  SizedBox(height: 30),

                  AppTextFormFieldWidget(
                    obscure: obscureText,
                    isIconVisibile: true,
                    passwordEyeIcon: obscureText
                        ? FontAwesomeIcons.solidEye
                        : FontAwesomeIcons.solidEyeSlash,

                    onPassIconTap: () {
                      obscureText = !obscureText;
                      setState(() {});
                    },

                    maxLines: 1,
                    hintTextStyle: TextStyle(
                        color: AppColors.appColor,
                        fontWeight: FontWeight.w300,
                        fontFamily: "Poppins",
                        fontStyle: FontStyle.normal,
                        fontSize: appDimens!.textw16),
                    textStyle: TextStyle(
                        color: AppColors.appColor,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Poppins",
                        fontStyle: FontStyle.normal,
                        fontSize: appDimens!.textw16),

                    // hintTextStyle: Text,
                    borderColor: AppColors.appColor,
                    filledColor: AppColors.appColor.withOpacity(0.2),
                    controller: passController,
                    prefixIcon: Icons.lock,
                    keyBoardType: TextInputType.emailAddress,
                    text: "Password",
                  ),
                  SizedBox(height: 90),
                  _bottomButton(model),

                  // _alreadyHaveAccount()
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  bool obscureText = true;

  _bottomButton(model) {
    return AppButtonWidget(
      onPressed: () {
        // Navigator.pushAndRemoveUntil(
        //     context,
        //     MaterialPageRoute(builder: (context) => DrawerScreen()),
        //     (route) => false);
        _validation(model);
      },
      title: "Login",
      textStyle: TextStyle(
          color: const Color(0xffffffff),
          fontWeight: FontWeight.w700,
          fontFamily: "Poppins",
          fontStyle: FontStyle.normal,
          fontSize: appDimens!.textw18),

      minWidth: MediaQuery.of(context).size.width * 0.6,

      borderRadius: BorderRadius.circular(4),
      // titleColor: AppColors.buttomTextColor,
      backgroundColor: AppColors.appColor,
    );
  }

  bool isLoading = false;
  _validation(model) async {
    if (emailController.text.trim().length == 0) {
      AppConstants().showToast(
          msg: "Please enter the email", fontSize: appDimens!.textw14);
    } else if (passController.text.trim().length == 0) {
      AppConstants().showToast(
          msg: "Please enter the password", fontSize: appDimens!.textw14);
    } else {
      setState(() {
        isLoading = true;
      });

      LoginModel response =
          await model.login(emailController.text, passController.text);

      // String jobDetail = response.employeeJobs.map((e) => JobDe)

      SharedPref prefs = SharedPref();
      await prefs.setString(
          AppStrings.employeeDetailModel, jsonEncode(response.employeeJobs));

      if (response.status == true) {
        setState(() {
          isLoading = false;
        });
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => BottomNavigationBarScreen()),
            (route) => false);
      } else {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  _alreadyHaveAccount() {
    return Text("Already have an account?",
        style: const TextStyle(
            color: const Color(0xff4681c3),
            fontWeight: FontWeight.w400,
            fontFamily: "Poppins",
            fontStyle: FontStyle.normal,
            fontSize: 18.0),
        textAlign: TextAlign.center);
  }
}
