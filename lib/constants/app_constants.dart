import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:jobtrackeremployee/constants/app_colors.dart';

class AppConstants {
  static progress(
    bool isLoading,
    BuildContext context,
  ) {
    return isLoading
        ? Container(
            color: Colors.black38,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.black38,
              child: SpinKitThreeBounce(
                  size: 35,
                  duration: new Duration(milliseconds: 1100),
                  color: AppColors.appColor),
            ),
          )
        : Container();
  }

  showToast({String? msg, double? fontSize = 15.0}) {
    Fluttertoast.showToast(
        msg: "$msg",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: fontSize);
  }

  String displayDateTime(String tod) {
    final dt = DateTime.parse(tod);
    final format = DateFormat("dd/MM/yyyy · hh:mm a"); //"24 Jun, 2021"
    return format.format(dt);
  }
    String displayDate(String tod) {
    final dt = DateTime.parse(tod);
    final format = DateFormat("dd MMMM, yyyy"); //"24 Jun, 2021"
    return format.format(dt);
  }

  String serverDate(String tod) {
    final dt = DateTime.parse(tod);
    final format = DateFormat("yyyy-MM-dd"); //"24 Jun, 2021"
    return format.format(dt);
  }

  String timeDisplay(String tod) {
    print(tod);
    final dt = DateTime.parse(tod);
    final format = DateFormat("hh:mm a"); //"12:57 AM"
    return format.format(dt);
  }
}
