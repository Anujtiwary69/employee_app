import 'package:jobtrackeremployee/models/login_model.dart';

class EmployeeModel {
  bool? status;
  List<EmployeeJobs>? employeeJobs;
  String? message;

  EmployeeModel({this.status, this.employeeJobs, this.message});

  EmployeeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['employee_jobs'] != null) {
      employeeJobs = <EmployeeJobs>[];
      json['employee_jobs'].forEach((v) {
        employeeJobs!.add(new EmployeeJobs.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.employeeJobs != null) {
      data['employee_jobs'] =
          this.employeeJobs!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}
