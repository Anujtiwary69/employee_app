class ClientModel {
  bool? status;
  List<ClientList>? client;
  String? message;

  ClientModel({this.status, this.client, this.message});

  ClientModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['client'] != null) {
      client = <ClientList>[];
      json['client'].forEach((v) {
        client!.add(new ClientList.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.client != null) {
      data['client'] = this.client!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class ClientList {
  int? id;
  String? businessName;
  String? contactFirstName;
  String? contactLastName;
  String? contactEmail;
  String? address;
  String? address2;
  String? city;
  String? state;
  String? country;
  String? postalCode;
  String? mobileNo;
  String? phoneNo;

  ClientList(
      {this.id,
      this.businessName,
      this.contactFirstName,
      this.contactLastName,
      this.contactEmail,
      this.address,
      this.address2,
      this.city,
      this.state,
      this.country,
      this.postalCode,
      this.mobileNo,
      this.phoneNo});

  ClientList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    businessName = json['business_name'];
    contactFirstName = json['contact_first_name'];
    contactLastName = json['contact_last_name'];
    contactEmail = json['contact_email'];
    address = json['address'];
    address2 = json['address2'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    postalCode = json['postal_code'];
    mobileNo = json['mobile_no'];
    phoneNo = json['phone_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['business_name'] = this.businessName;
    data['contact_first_name'] = this.contactFirstName;
    data['contact_last_name'] = this.contactLastName;
    data['contact_email'] = this.contactEmail;
    data['address'] = this.address;
    data['address2'] = this.address2;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['postal_code'] = this.postalCode;
    data['mobile_no'] = this.mobileNo;
    data['phone_no'] = this.phoneNo;
    return data;
  }
}
