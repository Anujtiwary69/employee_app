class AppStrings {
  static const String token = "token";
  static const String email = "email";
  static const String mobile = "mobile";
  static const String name = "name";
  static const String empCode = "empCode";
  static const String employeeDetailModel = "employeeDetail";

  static const String url = "http://adminjb.bszz1jzz3s-rz83y0wn04d7.p.runcloud.link/public";

  static const String baseUrl = url + "/api/employee/";
  static const String baseURLAdmin =  url + "/api/admin/";

  static const String loginUrl = baseUrl + "login";

  static const String jobUrl = baseUrl + "jobList";
  static const String jobNewURL = baseURLAdmin + "jobList";
  static const String jobDetailUrl = baseUrl + "getJobDetails";
  static const String viewGalleryUrl = baseUrl + "viewGallery";
  static const String jobStatusUrl = baseUrl + "jobStatusList";
  static const String jobEmployeeUrl = baseURLAdmin + "assignJobToEmployee";

  static const String jobTypeUrl = baseUrl + "jobTypeList";
  static const String clientListUrl = baseUrl + "clientList";
  static const String updateJobStatusUrl = baseUrl + "updateJobStatus";
  static const String submitUrl = baseUrl + "submitForm";
  static const String addJobUrl = baseUrl + "addJobByEmployee";

  // static const String clientListUrl = baseUrl + "clientList";

  static const String uploadPhotosUrl = baseUrl + "uploadPhotos";
  static const String changePasswordUrl = baseUrl + "changepwd";
  // static const String updateJobStatusUrl = baseUrl + "updateJobStatus";
}
