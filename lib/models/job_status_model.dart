class JobStatusModel {
  bool? status;
  List<JobStatus>? jobStatus;
  List<JobType>? jobType;
  String? message;

  JobStatusModel({
    this.status,
    this.jobStatus,
    this.message,
    this.jobType,
  });

  JobStatusModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['jobstatus'] != null) {
      jobStatus = <JobStatus>[];
      json['jobstatus'].forEach((v) {
        jobStatus!.add(new JobStatus.fromJson(v));
      });
    }
    if (json['job_type'] != null) {
      jobType = <JobType>[];
      json['job_type'].forEach((v) {
        jobType!.add(new JobType.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.jobStatus != null) {
      data['job_status'] = this.jobStatus!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class JobStatus {
  int? id;
  String? title;
  String? code;
  String? isDefault;
  String? status;

  JobStatus({this.id, this.title, this.code, this.isDefault, this.status});

  JobStatus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    code = json['code'];
    isDefault = json['is_default'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['code'] = this.code;
    data['is_default'] = this.isDefault;
    data['status'] = this.status;
    return data;
  }
}

class JobType {
  int? id;
  String? title;
  String? status;

  JobType({this.id, this.title, this.status});

  JobType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['status'] = this.status;
    return data;
  }
}
