class JobDetailsModel {
  bool? status;
  String? message;
  JobDetail? jobDetail;

  JobDetailsModel({this.status, this.message, this.jobDetail});

  JobDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    jobDetail = json['job_detail'] != null
        ? new JobDetail.fromJson(json['job_detail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.jobDetail != null) {
      data['job_detail'] = this.jobDetail!.toJson();
    }
    return data;
  }
}

class JobDetail {
  int? id;
  String? jobCode;
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
  int? jobStatusUpdatedBy;
  String? status;
  String? subTask;
  String? quantity1;
  int? current_status;
  List<Employee>? employee;

  JobDetail({
    this.id,
    this.jobCode,
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
    this.jobStatusUpdatedBy,
    this.subTask,
    this.quantity1,
    this.status,
    this.employee,
    this.current_status,

  });

  JobDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobCode = json['job_code'];
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
    jobStatusUpdatedBy = json['job_status_updated_by'];
    subTask = json['subTask'];
    quantity1 = json['quantity'];
    status = json['status'];
    current_status =  json['current_status'];
    if (json['employee'] != null) {
      employee = <Employee>[];
      json['employee'].forEach((v) {
        employee!.add(new Employee.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['job_code'] = this.jobCode;
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
    data['job_status_updated_by'] = this.jobStatusUpdatedBy;
    data['subTask'] = this.subTask;
    data['quantity'] = this.quantity1;
    data['status'] = this.status;
    data['current_status'] = this.current_status;
    if (this.employee != null) {
      data['employee'] = this.employee!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Employee {
  int? id;
  String? employeeCode;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? phoneNo;
  String? address;
  String? address2;
  String? city;
  String? state;
  String? country;
  String? postalCode;
  String? status;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;

  Employee(
      {this.id,
      this.employeeCode,
      this.firstName,
      this.lastName,
      this.email,
      this.password,
      this.phoneNo,
      this.address,
      this.address2,
      this.city,
      this.state,
      this.country,
      this.postalCode,
      this.status,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt});

  Employee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeCode = json['employee_code'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    password = json['password'];
    phoneNo = json['phone_no'];
    address = json['address'];
    address2 = json['address2'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    postalCode = json['postal_code'];
    status = json['status'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['employee_code'] = this.employeeCode;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['phone_no'] = this.phoneNo;
    data['address'] = this.address;
    data['address2'] = this.address2;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['postal_code'] = this.postalCode;
    data['status'] = this.status;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
