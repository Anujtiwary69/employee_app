import 'dart:collection';
import 'dart:convert';


import 'package:jobtrackeremployee/constants/app_strings.dart';
import 'package:jobtrackeremployee/screens/login.dart';
import 'package:jobtrackeremployee/utilities/shared_pref.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiManager {
  var headers;
  String aToken = '';
  //
  // static Future<bool> checkInternet() async {
  //   var connectivityResult = await (Connectivity().checkConnectivity());
  //   if (connectivityResult == ConnectivityResult.none) {
  //     return false;
  //   } else {
  //     return true;
  //   }
  // }

  getCall(String url) async {
    var uri = Uri.parse(url);
    print(uri);
    http.Response response = await http.get(uri);
    print("this is the resposne ${response.body}");
    print(response.headers);
    print("status code : ${response.statusCode}");
    if (response.statusCode == 401) {
      print("This is response code 401");
    } else {
      return await json.decode(response.body);
    }
  }

  getCallwithheader(String url, context, bool isapiv2) async {
    SharedPref prefs = SharedPref();
    var token = await prefs.getString(AppStrings.token);
    var uri = Uri.parse(url);
    print("$token");
    print(uri);
    http.Response response = await http.get(uri, headers: {
      "API-TOKEN": isapiv2 ? "apiv2-token-development" : token!
    });
    // final response = await http.get(url);
    print(response.statusCode);
    // print(json.decode(response.body));
    if (response.statusCode == 401) {
      print("This is response code 401");
    pushNewScreen(context, screen: LoginScreen(),withNavBar: false);
      return json.decode(response.body);
    } else {
      print("This is else part");

      return await json.decode(response.body);
    }

    // return await response.data;
  }

  postCall(String url, Map request) async {
    print("request " + request.toString());
    Map<String, String> header;
    header = {"Accept": "*/*", "API-TOKEN": "apiv2-token-development"};
    // }
    var uri = Uri.parse(url);
    print(uri);
    http.Response response = await http.post(
      uri,
      body: request,
      headers: header,
    );
    print(response.body);
    if (response.statusCode == 401) {
      print("This is response code 401");
      return await json.decode(response.body);
    } else {
      print("This is else part");

      return await json.decode(response.body);
    }
  }

  postCallWithHeader(String url, Map request) async {
    print("post call with header");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(AppStrings.token);
    var uri = Uri.parse(url);
    print(uri);
    print(request);
    http.Response response =
        await http.post(uri, body: request, headers: {"API-TOKEN": "$token"});
    // final response = await http.get(url);
    print(response);
    Map<String, dynamic> errorRespose = new HashMap();
    print(response.statusCode);
    // print(json.decode(response.body));
    if (response.statusCode == 401) {
      print("This is response code 401");
      return errorRespose;
    } else {
      print("This is else part");
      return await json.decode(response.body);
    }
  }
}
