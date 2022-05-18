import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:images_picker/images_picker.dart';
import 'package:jobtrackeremployee/constants/app_constants.dart';
import 'package:jobtrackeremployee/constants/app_strings.dart';
import 'package:jobtrackeremployee/models/client_model.dart';
import 'package:jobtrackeremployee/models/common_model.dart';
import 'package:jobtrackeremployee/models/employee_model.dart';
import 'package:jobtrackeremployee/models/gallery_model.dart';
import 'package:jobtrackeremployee/models/job_detail_model.dart';
import 'package:jobtrackeremployee/models/job_status_model.dart';
import 'package:jobtrackeremployee/models/login_model.dart';
import 'package:jobtrackeremployee/utilities/api.dart';
import 'package:jobtrackeremployee/utilities/shared_pref.dart';

import '../models/job_model.dart';

class JobProvider extends ChangeNotifier {
  Api _api = Api();
  SharedPref prefs = SharedPref();

  List<EmployeeJobs>? _employeeJobs;
  List<EmployeeJobs>? get employeeJobs => _employeeJobs;

  List<JobList>? _jobList;
  List<JobList>? get jobList1 => _jobList;

  List<JobStatus>? _jobStatus;
  List<JobStatus>? get jobStatus => _jobStatus;

  List<JobType>? _jobType;
  List<JobType>? get jobType => _jobType;




  Future<EmployeeModel> getJobList(context) async {
    print("in the login");
    EmployeeModel success = await _api.getjobList(context);
    var loggedIn;
    if (success != null) {
      _employeeJobs = success.employeeJobs;

      // AppConstants().showToast(msg: "${success.message}");
      loggedIn = true;
    } else {
      // AppConstants().showToast(msg: "${success.message}");
      loggedIn = false;
    }
    notifyListeners();
    return success;
  }
  Future<JobModel> getJobListNew(context) async {
    print("in the loginsdsd");
    // _jobList =[];

    JobModel response = await _api.getjobListNew(context);
    print(response.message);
    print("in the login");
    if (response.status == true) {
      print("in the login");
      _jobList = response.jobList!;
      print(response.jobList?.length);
      AppConstants().showToast(msg: "${response.message}");
      // loggedIn = true;
    } else {
      AppConstants().showToast(msg: "${response.message}");
      // loggedIn = false;
    }
    notifyListeners();
    return response;
  }

  List<ClientList>? _clientList = [];
  List<ClientList>? get clientList => _clientList;

  Future<ClientModel> getClientList(context) async {
    _clientList = [];
    ClientModel response = await _api.getClientList(context);

    if (response.status == true) {
      _clientList = response.client!;
      // AppConstants().showToast(msg: "${response.message}");
    } else {
      // AppConstants().showToast(msg: "${response.message}");
    }
    notifyListeners();
    return response;
  }

  Future<JobStatusModel> getJobType(context) async {
    _jobType = [];
    JobStatusModel response = await _api.getJobType(context);
    if (response.status == true) {
      _jobType = response.jobType!;
      AppConstants().showToast(msg: "${response.message}");
    } else {
      AppConstants().showToast(msg: "${response.message}");
    }
    notifyListeners();
    return response;
  }

  JobDetail? _jobDetail;
  JobDetail? get jobDetail => _jobDetail;
  Future<JobDetailsModel> getJobDetail(context, String id) async {
    print("in the login");
    JobDetailsModel success = await _api.getJobDetails(context, id);
    var loggedIn;
    if (success != null) {
      _jobDetail = success.jobDetail;
      print(_jobDetail);
      // AppConstants().showToast(msg: "${success.message}");
      loggedIn = true;
    } else {
      // AppConstants().showToast(msg: "${success.message}");
      loggedIn = false;
    }
    notifyListeners();
    return success;
  }
  //this section to assign the employee to specific job
  Future<CommonResponse> assignToEmployee({
    context,
    String? jobId,
    String? employeeId,
  }) async {
    var request = new HashMap();
    request["job_id"] = "$jobId";
    request["employee_id"] = "$employeeId";

    // request["job_status_id"] = "$statusId";
    // request["client_id"] = '$clientId';
    // request["employee_id"] = "$statusId";

    CommonResponse response = await _api.assignEmployee(
        context: context, request: request, url: AppStrings.jobEmployeeUrl);
    if (response.status == true) {
      // AppConstants().showToast(msg: "Employee assigned successfully");
    } else {
      // AppConstants().showToast(msg: "${r}");
    }
    notifyListeners();
    return response;
  }


  List<Gallery>? _gallery;
  List<Gallery>? get gallery => _gallery;
  Future<GalleryResponse> getGallaryData(context, String id) async {
    print("in the login");
    var request = new HashMap();
    request["job_id"] = "$id";
    GalleryResponse success = await _api.getGalleryDetails(context, request);

    var loggedIn;
    if (success != null) {
      // _jobDetail = success.jobDetail;
      _gallery = success.gallery;
      // AppConstants().showToast(msg: "${success.message}");
      loggedIn = true;
    } else {
      // AppConstants().showToast(msg: "${success.message}");
      loggedIn = false;
    }
    notifyListeners();
    return success;
  }

  // List<JobStatus> _jobStatus = [];
  // List<JobStatus> get jobStatus => _jobStatus;

  Future<JobStatusModel> getJobStatusList(context) async {
    _jobStatus = [];
    JobStatusModel response = await _api.getJobStatusList(context);
    if (response.status == true) {
      _jobStatus = response.jobStatus;
      AppConstants().showToast(msg: "${response.message}");
    } else {
      AppConstants().showToast(msg: "${response.message}");
    }
    notifyListeners();
    return response;
  }

  Future<CommonResponse> addEditJob(
      {context,
      bool? isEdit,
      String? title,
      String? status,
      String? description,
      String? clientId,
      String? startDate,
      String? startTime,
      String? contactPerson,
      String? jobTypeId,
      String? jobStatusId,
      String? jobId,
      String? state,
      String? city,
      String? address,
      String? statusId}) async {
    var request = new HashMap();
    request["title"] = "$title";
    request["description"] = '$description';
    request["client_id"] = '$clientId';
    request["start_date"] = '$startDate';
    request["start_time"] = '$startTime';
    request["contact_person"] = '$contactPerson';
    request["job_type_id"] = '$jobTypeId';
    request["job_status_id"] = '$jobStatusId';
    request["job_id"] = '$jobId';
    request["address"] = '$address';
    request["city"] = '$city';
    request["state"] = '$state';
    request["status"] = "$status";
    if (isEdit!) {
      request["job_status_id"] = "$statusId";
    }

    CommonResponse response = await _api.addEditJob(
        context: context, request: request, url: AppStrings.addJobUrl);
    if (response.status == true) {
      // AppConstants().showToast(msg: "${response.message}");
    } else {
      // AppConstants().showToast(msg: "${response.message}");
    }
    notifyListeners();
    return response;
  }

  Future<CommonResponse> updateStatus(
      context, String jobStatusId, String job_id) async {
    print("in the login");
    var request = HashMap();
    request["job_status_id"] = jobStatusId;
    request["job_id"] = job_id;
    CommonResponse success = await _api.updateJobStatus(context, request);
    // _jobStatus = success.jobstatus!;
    var loggedIn;
    if (success.status == true) {
      // AppConstants().showToast(msg: "${success.message}");
      AppConstants().showToast(msg: "Uploaded Successfully");

      loggedIn = true;
    } else {
      AppConstants().showToast(msg: "${success.message}");
      loggedIn = false;
    }
    notifyListeners();
    return success;
  }

  Future<CommonResponse> uploadPhotos(
      context, List<Media>? images, String? jobId) async {
    print("in the login");
    CommonResponse success = await _api.uploadPhotos(context, images, jobId);
    // _jobStatus = success.jobstatus!;
    var loggedIn;
    if (success.status == true) {
      AppConstants().showToast(msg: "Uploaded Successfully");
      loggedIn = true;
    } else {
      AppConstants().showToast(msg: "${success.message}");
      loggedIn = false;
    }
    notifyListeners();
    return success;
  }

  Future<CommonResponse> submitForm(
    context, {
    String? jobId,
    String? lengthOfTrench,
    String? depthOfTrench,
    String? width,
    String? conCreteCutting,
    String? reinstallment,
    String? stomeware_reinstallment,
    String? footpath_length,
    String? footpathWidth,
    String? crossoverLenth,
    String? crossoverWidth,
    String? kerbChannel,
    String? startTie,
    String? finishTime,
    String? tenmm,
    String? twentymm,
    String? fiftymm,
    String? fiftyplus,
    String? rootGrowthDepth,
    String? treeRoots,
    String? disposalSlurry,
    String? jobNumber,
    String? clientName,
    String? clientPhoneNumber,
    String? preWorkPhotos,
    String? treeRootPhotos,
    String? postWorkCompletionPhotos,
  }) async {
    print("in the login");
    var request = new HashMap();
    request["job_id"] = "$jobId";
    request["length_of_trench"] = "$lengthOfTrench";
    request["depth_of_trench"] = "$depthOfTrench";
    request["width"] = "$width";
    request["concreate_cutting"] = "$conCreteCutting";
    request["reinstallment"] = "$reinstallment";
    request["stomeware_reinstallment"] = "$stomeware_reinstallment";
    request["footpath_length"] = "$footpath_length";
    request["footpath_width"] = "$footpathWidth";
    request["crossover_length"] = "$crossoverLenth";
    request["crossover_width"] = "$crossoverWidth";
    request["kerb_channel"] = "$kerbChannel";
    request["start_time"] = "$startTie";
    request["finish_time"] = "$finishTime";
    request["ten_mm_and_under"] = "$tenmm";
    request["ten_mm_to_twenty_mm"] = "$twentymm";
    request["twenty_mm_to_fifty_mm"] = "$fiftymm";
    request["fifty_mm_plus"] = "$fiftyplus";
    request["Root_growth_depth"] = "$rootGrowthDepth";
    request["tree_roots"] = "$treeRoots";
    request["disposal_slurry"] = "$disposalSlurry";
    request["job_or_po_number"] = "$jobNumber";
    request["client_name"] = "$clientName";
    request["client_phone_number"] = "$clientPhoneNumber";
    request["pre_work_photos"] = "$preWorkPhotos";
    request["tree_root_photos"] = "$treeRootPhotos";
    request["post_work_completion_photos"] = "$postWorkCompletionPhotos";

    CommonResponse success =
        await _api.submitForm(context: context, request: request);
    // _jobStatus = success.jobstatus!;
    var loggedIn;
    if (success != null) {
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
