import 'package:flutter/material.dart';
import 'package:jobtrackeremployee/constants/app_colors.dart';
import 'package:jobtrackeremployee/constants/app_strings.dart';
import 'package:jobtrackeremployee/screens/bottom_navigation_bar.dart';
import 'package:jobtrackeremployee/screens/home_screen.dart';
import 'package:jobtrackeremployee/screens/login.dart';
import 'package:jobtrackeremployee/utilities/shared_pref.dart';
import 'package:jobtrackeremployee/widgets/app_button_widget.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Data",style: TextStyle(fontSize: 25),),
      // ),

      body: _mainBody(context),
    );
  }

  _verify(context) async {
    SharedPref pref = SharedPref();
    var token = await pref.getString(AppStrings.token);
    if (token == null) {
      _login(context);
    } else {
      _homeScreen(context);
    }
  }

  _login(context) => Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);
  _homeScreen(context) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => BottomNavigationBarScreen()),
      (route) => false);
  _mainBody(context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: 100,
              height: 100,
              child: Image.asset("assets/logo/logo.png")),
          SizedBox(height: 30),
          AppButtonWidget(
            onPressed: () {
              // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginScreen()), (route) => false);

              _verify(context);
            },
            title: "Get Started",
            textStyle: const TextStyle(
                color: const Color(0xffffffff),
                fontWeight: FontWeight.w700,
                fontFamily: "Poppins",
                fontStyle: FontStyle.normal,
                fontSize: 18.0),
            minWidth: MediaQuery.of(context).size.width * 0.5,
            borderRadius: BorderRadius.circular(37),

            // titleColor: AppColors.buttomTextColor,
            backgroundColor: AppColors.appColor,
          )
        ],
      ),
    );
  }
}
