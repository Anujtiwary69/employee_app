class CommonResponse {
  bool? status;
  String? message;
  bool? formOpen;

  CommonResponse({this.status, this.formOpen, this.message});

  CommonResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    formOpen = json['form_open'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['form_open'] = this.formOpen;
    return data;
  }
}
