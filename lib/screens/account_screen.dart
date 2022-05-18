import 'package:flutter/material.dart';
import 'package:jobtrackeremployee/constants/app_colors.dart';
import 'package:jobtrackeremployee/constants/app_dimens.dart';
import 'package:jobtrackeremployee/constants/app_strings.dart';
import 'package:jobtrackeremployee/screens/change_password.dart';
import 'package:jobtrackeremployee/screens/login.dart';
import 'package:jobtrackeremployee/utilities/shared_pref.dart';
import 'package:jobtrackeremployee/widgets/app_bar_widget.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  AppDimens? appDimens;
  SharedPref prefs = SharedPref();
  String? name, email, phone, id;
  setData() async {
    name = await prefs.getString(AppStrings.name);
    email = await prefs.getString(AppStrings.email);
    phone = await prefs.getString(AppStrings.mobile);
    id = await prefs.getString(AppStrings.empCode);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setData();
  }

  @override
  Widget build(BuildContext context) {
    appDimens = AppDimens(MediaQuery.of(context).size.width);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 56),
        child: AppBarWidget(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              "assets/logo/logo2.png",
              height: 41,
              width: 41,
            ),
          ),
          // text: "Account",
          title: Text(
            "Account",
            style:
                TextStyle(color: Colors.black87, fontSize: appDimens!.textw20),
          ),
        ),
      ),
      body: _mainBody(),
    );
  }

  _mainBody() {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$name (ID-00$id)",
            style: TextStyle(
                fontSize: appDimens!.textw28,
                fontWeight: FontWeight.w600,
                color: AppColors.appColor),
          ),
          iconText(Icons.email_outlined, "$email", () {}),
          iconText(Icons.phone, "$phone", () {}),
          iconText(Icons.vpn_key_rounded, "Change Password", () {
            pushNewScreen(context, screen: ChangePassword(), withNavBar: true);
          }),
          iconText(Icons.logout, "Logout", () async {
            SharedPref prefs = SharedPref();

            await prefs.clear();
            pushNewScreen(context, screen: LoginScreen(), withNavBar: false);
          }),
        ],
      ),
    );
  }

  iconText(IconData icon, String text, void Function()? onTap) {
    return Container(
        child: ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      onTap: onTap!,
      leading: Icon(
        icon,
        size: appDimens!.textw40,
        color: AppColors.appColor,
      ),
      title: Text(
        text,
        style:
            TextStyle(fontSize: appDimens!.textw20, color: AppColors.appColor),
      ),
    )
        //  Row(
        //   children: [
        //     Icon(
        //       icon,
        //       size: appDimens!.textw40,
        //       color: AppColors.appColor,
        //     ),
        //     SizedBox(width: 10),
        // Text(
        //   text,
        //   style: TextStyle(
        //       fontSize: appDimens!.textw20, color: AppColors.appColor),
        // )
        //   ],
        // ),
        );
  }
}
