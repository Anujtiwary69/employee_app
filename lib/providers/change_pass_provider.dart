import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:jobtrackeremployee/constants/app_constants.dart';
import 'package:jobtrackeremployee/constants/app_strings.dart';
import 'package:jobtrackeremployee/models/common_model.dart';
import 'package:jobtrackeremployee/utilities/api.dart';
import 'package:jobtrackeremployee/utilities/shared_pref.dart';

class ChangePassProvider extends ChangeNotifier {
  Api _api = Api();
  SharedPref prefs = SharedPref();

  Future<CommonResponse> changePass(context, String? currentPass,
      String? newPass, String? confirmPass) async {
    print("in the login");
    var request = new HashMap();
    request["current_password"] = currentPass;
    request["new_password"] = newPass;
    request["new_confirm_password"] = confirmPass;
    CommonResponse success = await _api.changePasswor(
        context: context, request: request, url: AppStrings.changePasswordUrl);
    // ignore: unnecessary_null_comparison
    if (success != null) {
      // _employeeJobs = success.employeeJobs;

      AppConstants().showToast(msg: "${success.message}");
    } else {
      AppConstants().showToast(msg: "${success.message}");
    }
    notifyListeners();
    return success;
  }
}
