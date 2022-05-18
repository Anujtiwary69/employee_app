import 'package:flutter/foundation.dart';
import 'package:jobtrackeremployee/constants/app_constants.dart';
import 'package:jobtrackeremployee/constants/app_strings.dart';
import 'package:jobtrackeremployee/models/login_model.dart';
import 'package:jobtrackeremployee/utilities/api.dart';
import 'package:jobtrackeremployee/utilities/shared_pref.dart';

class LoginProvider extends ChangeNotifier {
  Api _api = Api();
  SharedPref prefs = SharedPref();

  Future<LoginModel> login(String email, String password) async {
    print("in the login");
    LoginModel success = await _api.loginApi(email, password, "defaulttoken");
    var loggedIn;
    if (success != null) {
      await prefs.setString(AppStrings.token, success.token);
      await prefs.setString(AppStrings.email, success.employee!.email);
      await prefs.setString(AppStrings.mobile, success.employee!.phoneNo);
      await prefs.setString(AppStrings.empCode, "${success.employee!.id}");
      await prefs.setString(AppStrings.name,
          "${success.employee!.firstName} ${success.employee!.lastName}");
      print(success.token);

      AppConstants().showToast(msg: "${success.message}");
      loggedIn = true;
    } else {
      AppConstants().showToast(msg: "${success.message}");
      loggedIn = false;
    }
    notifyListeners();
    return success;
  }
}
