class GalleryResponse {
  bool? status;
  List<Gallery>? gallery;
  String? message;

  GalleryResponse({this.status, this.gallery, this.message});

  GalleryResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['gallery'] != null) {
      gallery =  <Gallery>[];
      json['gallery'].forEach((v) {
        gallery!.add(new Gallery.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.gallery != null) {
      data['gallery'] = this.gallery!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Gallery {
  int? id;
  int? jobId;
  String? fileName;
  String? fileType;
  String? fileSize;
  int? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;

  Gallery(
      {this.id,
      this.jobId,
      this.fileName,
      this.fileType,
      this.fileSize,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt});

  Gallery.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobId = json['job_id'];
    fileName = json['file_name'];
    fileType = json['file_type'];
    fileSize = json['file_size'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['job_id'] = this.jobId;
    data['file_name'] = this.fileName;
    data['file_type'] = this.fileType;
    data['file_size'] = this.fileSize;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
