// import 'dart:collection';
// import 'dart:io';

import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:images_picker/images_picker.dart';
import 'package:jobtrackeremployee/constants/app_strings.dart';
import 'package:jobtrackeremployee/models/client_model.dart';
import 'package:jobtrackeremployee/models/common_model.dart';
import 'package:jobtrackeremployee/models/employee_model.dart';
import 'package:jobtrackeremployee/models/gallery_model.dart';
import 'package:jobtrackeremployee/models/job_detail_model.dart';
import 'package:jobtrackeremployee/models/job_status_model.dart';
import 'package:jobtrackeremployee/models/login_model.dart';
import 'package:jobtrackeremployee/utilities/api_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import '../models/job_model.dart';

class Api {
//   // login api

  Future<LoginModel> loginApi(
      String email, String password, String? deviceToken) async {
    print("in Api in getLogin");
    var request = new HashMap();
    request["email"] = email;
    request["password"] = password;
    request["device_token"] = "$deviceToken";
    request["device_type"] = Platform.isIOS ? "IOS" : "ANDROID";

    var response = await ApiManager().postCall(AppStrings.loginUrl, request);
    return LoginModel.fromJson(response);
  }

  Future<EmployeeModel> getjobList(
    context,
  ) async {
    var response =
        await ApiManager().getCallwithheader(AppStrings.jobUrl, context, false);
    print(response);
    return EmployeeModel.fromJson(response);
  }
  Future<JobModel> getjobListNew(
      context,
      ) async {
    var response =
    await ApiManager().getCallwithheader(AppStrings.jobNewURL, context, false);
    print(response);
    return JobModel.fromJson(response);
  }

  Future<JobDetailsModel> getJobDetails(context, String id) async {
    var response = await ApiManager()
        .getCallwithheader("${AppStrings.jobDetailUrl}/$id", context, false);
    print(response);
    return JobDetailsModel.fromJson(response);
  }

  // /assign employee to specific job
  Future<CommonResponse> assignEmployee({context, Map? request, url}) async {
    var response = await ApiManager().postCallWithHeader(url, request!);
    print(response);
    return CommonResponse.fromJson(response);
  }

  Future<GalleryResponse> getGalleryDetails(context, Map request) async {
    var response = await ApiManager().postCallWithHeader(
      "${AppStrings.viewGalleryUrl}",
      request,
    );
    print(response);
    return GalleryResponse.fromJson(response);
  }

  Future<JobStatusModel> getJobStatusList(
    context,
  ) async {
    var response = await ApiManager()
        .getCallwithheader("${AppStrings.jobStatusUrl}", context, true);
    print(response);
    return JobStatusModel.fromJson(response);
  }

  Future<ClientModel> getClientList(
    context,
  ) async {
    var response = await ApiManager()
        .getCallwithheader(AppStrings.clientListUrl, context, false);
    print(response);
    return ClientModel.fromJson(response);
  }

  Future<CommonResponse> updateJobStatus(context, Map request) async {
    var response = await ApiManager()
        .postCallWithHeader("${AppStrings.updateJobStatusUrl}", request);
    print(response);
    return CommonResponse.fromJson(response);
  }

  Future<CommonResponse> updatePhotos(context, Map request) async {
    var response = await ApiManager()
        .postCallWithHeader("${AppStrings.uploadPhotosUrl}", request);
    print(response);
    return CommonResponse.fromJson(response);
  }

  Future<JobStatusModel> getJobType(
    context,
  ) async {
    var response = await ApiManager()
        .getCallwithheader(AppStrings.jobTypeUrl, context, false);
    print(response);
    return JobStatusModel.fromJson(response);
  }

  Future<CommonResponse> uploadPhotos(
    context,
    List<Media>? images,
    String? jobId,
  ) async {
    // var response = await ApiManager().postCallWithHeader(
    //   AppStrings.addChildActivityUrl,
    //   request,
    // );
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(AppStrings.token);
    print(token);
    var uri = Uri.parse(AppStrings.uploadPhotosUrl);
    print(uri);
    http.MultipartRequest request = http.MultipartRequest(
      "POST",
      uri,
    );
    // var multipartFile =
    // await http.MultipartFile.fromPath("image_1", image!.path);

    List<MultipartFile> imageList = <MultipartFile>[];
    for (int i = 0; i < images!.length; i++) {
      File imageFile = File(images[i].path.toString());
      var stream = new http.ByteStream(Stream.castFrom(imageFile.openRead()));
      var length = await imageFile.length();
      print(length);
      var multipartFile = new http.MultipartFile("photos[]", stream, length,
          filename: basename(imageFile.path));
      imageList.add(multipartFile);
    }

    request.files.addAll(imageList);
    request.fields["job_id"] = "$jobId";

    var headers = {"Accept": "*/*", "API-TOKEN": token!};
    request.headers.addAll(headers);

    request.files.forEach((element) {
      print(element.filename);
    });
    print(request.fields);
    print(request.headers);
    // var response = await request.send();
    //
    // var responseData = await response.stream.bytesToString();
    //
    // var result = jsonDecode(responseData);
    // print("response of the multirequest$result");
    //
    // return CommonModel.fromJson(result);
    var childResponse;
    await request.send().then((response) async {
      print(response.statusCode);
      print(response.request);
      print(response.stream);
      // listen for response
      response.stream.transform(utf8.decoder).listen((value) {
        // return CommonModel.fromJson(jsonDecode(value));
        childResponse = value;

        print("this $value");
      });
    }).catchError((e) {
      print("errror $e");
    });
    print("multi part response $childResponse");
    return CommonResponse.fromJson(jsonDecode(childResponse));
  }

  Future<CommonResponse> submitForm({context, Map? request, url}) async {
    var response =
        await ApiManager().postCallWithHeader(AppStrings.submitUrl, request!);
    print(response);
    return CommonResponse.fromJson(response);
  }

  Future<CommonResponse> changePasswor({context, Map? request, url}) async {
    var response =
        await ApiManager().postCallWithHeader(AppStrings.submitUrl, request!);
    print(response);
    return CommonResponse.fromJson(response);
  }

  Future<CommonResponse> addEditJob({context, Map? request, url}) async {
    var response = await ApiManager().postCallWithHeader(url, request!);
    print(response);
    return CommonResponse.fromJson(response);
  }
  // Future<ClientModel> getClientList(
  //   context,
  // ) async {
  //   var response = await ApiManager()
  //       .getCallwithheader(AppStrings.clientListUrl, context, false);
  //   print(response);
  //   return ClientModel.fromJson(response);
  // }

}
