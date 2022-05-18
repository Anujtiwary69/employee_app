
import 'client_model.dart';
import 'job_status_model.dart';

class JobModel {
  bool? status;
  List<JobList>? jobList;
  String? message;

  JobModel({this.status, this.jobList, this.message});

  JobModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['job_list'] != null) {
      jobList = <JobList>[];
      json['job_list'].forEach((v) {
        jobList!.add(new JobList.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.jobList != null) {
      data['job_list'] = this.jobList!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class JobList {
  int? id;
  String? jobCode;
  int? jobParentId;
  int? clientId;
  int? jobTypeId;
  String? title;
  String? description;
  String? startDate;
  String? startTime;
  String? contactPerson;
  String? conactNo;
  String? address;
  String? address2;
  String? city;
  String? state;
  String? country;
  String? postalCode;
  int? jobStatusId;
  String? jobStatusTitle;
  String? status;
  ClientList? client;
  JobType? jobType;
  String? subTask;
  String? quantity;
  String? lat;
  String? lan;

  JobList(
      {this.id,
        this.jobCode,
        this.jobParentId,
        this.clientId,
        this.jobTypeId,
        this.title,
        this.description,
        this.startDate,
        this.startTime,
        this.contactPerson,
        this.conactNo,
        this.address,
        this.address2,
        this.city,
        this.state,
        this.country,
        this.postalCode,
        this.jobStatusId,
        this.jobStatusTitle,
        this.status,
        this.client,
        this.jobType,this.subTask,this.quantity,this.lat,this.lan

      });

  JobList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobCode = json['job_code'];
    jobParentId = json['job_parent_id'];
    clientId = json['client_id'];
    jobTypeId = json['job_type_id'];
    title = json['title'];
    description = json['description'];
    startDate = json['start_date'];
    startTime = json['start_time'];
    contactPerson = json['contact_person'];
    conactNo = json['conact_no'];
    address = json['address'];
    address2 = json['address2'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    postalCode = json['postal_code'];
    jobStatusId = json['job_status_id'];
    jobStatusTitle = json['job_status_title'];
    status = json['status'];
    quantity =  json['quantity'];
    subTask =  json['subTask'];
    lan =  json['lan'];
    lat =  json['lat'];
    client =
    json['client'] != null ? new ClientList.fromJson(json['client']) : null;
    jobType = json['job_type'] != null
        ? new JobType.fromJson(json['job_type'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['job_code'] = this.jobCode;
    data['job_parent_id'] = this.jobParentId;
    data['client_id'] = this.clientId;
    data['job_type_id'] = this.jobTypeId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['start_date'] = this.startDate;
    data['start_time'] = this.startTime;
    data['contact_person'] = this.contactPerson;
    data['conact_no'] = this.conactNo;
    data['address'] = this.address;
    data['address2'] = this.address2;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['postal_code'] = this.postalCode;
    data['job_status_id'] = this.jobStatusId;
    data['job_status_title'] = this.jobStatusTitle;
    data['status'] = this.status;
    data['quantity'] =  this.quantity;
    data['lat'] =  this.lat;
    data['lan'] =  this.lan;
    data[''] =  this.subTask;
    if (this.client != null) {
      data['client'] = this.client!.toJson();
    }
    if (this.jobType != null) {
      data['job_type'] = this.jobType!.toJson();
    }
    return data;
  }
}
