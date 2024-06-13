class User {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  int? gallaryId;
  String? isSeen;
  String? status;
  String? hash;
  String? createdBy;
  int? updatedBy;
  String? deletedAt;
  String? rememberToken;
  String? createdAt;
  String? updatedAt;
  String? token;

  User(
      {this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.gallaryId,
        this.isSeen,
        this.status,
        this.hash,
        this.createdBy,
        this.updatedBy,
        this.deletedAt,
        this.rememberToken,
        this.createdAt,
        this.updatedAt,
        this.token,
      });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    gallaryId = json['gallary_id'];
    isSeen = json['is_seen'];
    status = json['status'];
    hash = json['hash'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedAt = json['deleted_at'];
    rememberToken = json['remember_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    token = json['token'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['gallary_id'] = gallaryId;
    data['is_seen'] = isSeen;
    data['status'] = status;
    data['hash'] = hash;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_at'] = deletedAt;
    data['remember_token'] = rememberToken;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['token'] = token;
    return data;
  }
}