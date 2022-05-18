class LoginModel {
  bool? status;
  String? token;
  Employee? employee;
  List<EmployeeJobs>? employeeJobs;
  String? message;

  LoginModel(
      {this.status,
      this.token,
      this.employeeJobs,
      this.message,
      this.employee});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    token = json['token'];
    employee = json['employee'] != null
        ? new Employee.fromJson(json['employee'])
        : null;
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
    data['token'] = this.token;
    if (this.employee != null) {
      data['employee'] = this.employee!.toJson();
    }
    if (this.employeeJobs != null) {
      data['employee_jobs'] =
          this.employeeJobs!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class EmployeeJobs {
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
  List<Employee>? employee;
  String? lat;
  String? lang;

  EmployeeJobs({
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
    this.status,
    this.employee,
    this.lat,
    this.lang,
  });

  EmployeeJobs.fromJson(Map<String, dynamic> json) {
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
    status = json['status'];
    lat = json['lat'];
    lang = json['lan'];
    if (json['employee'] != null) {
      employee = <Employee>[];
      json['employee'].forEach((v) {
        employee!.add(new Employee.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    data['status'] = this.status;
    data['lat'] = this.lat;
    data['lan'] = this.lang;
    if (this.employee != null) {
      data['employee'] = this.employee!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Employee {
  int? id;
  Null employeeCode;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? phoneNo;
  Null address;
  Null address2;
  Null city;
  Null state;
  Null country;
  Null postalCode;
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
