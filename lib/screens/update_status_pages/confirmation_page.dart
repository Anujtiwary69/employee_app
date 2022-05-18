import 'package:flutter/material.dart';
import 'package:jobtrackeremployee/constants/app_colors.dart';
import 'package:jobtrackeremployee/constants/app_dimens.dart';

class ConfirmationPage extends StatelessWidget {
  AppDimens? appDimens;
  @override
  Widget build(BuildContext context) {
    appDimens = AppDimens(MediaQuery.of(context).size.width);
    return Scaffold(
      body: mainBody(context),
    );
  }

  mainBody(context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Icon(
              Icons.check,
              size: 200,
              color: AppColors.appColor,
            ),
          ),
          Text(
            "Your form has been updated",
            style: TextStyle(
              fontSize: appDimens!.textw24,
              color: AppColors.appColor,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          MaterialButton(
            padding: EdgeInsets.all(15),
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: BorderSide(color: AppColors.textColor)),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text(
              "Return to update",
              style: TextStyle(
                fontSize: appDimens!.textw18,
                color: AppColors.appColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
