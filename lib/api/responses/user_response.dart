

import '../../constants/app_constants.dart';
import '../../models/user_data.dart';

class UpdateUserResponse {
  UserData? data;
  String? status;
  String? message;
  int? statusCode;

  UpdateUserResponse(
      {this.data, this.status, this.message, this.statusCode});

  UpdateUserResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
    status = json['status'];
    message = json['message'];
    statusCode = json['status_code'];
  }

  UpdateUserResponse.withError(String error) {
    data = null;
    status = AppConstants.STATUS_ERROR;
    message = error;
    statusCode = 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    data['status'] = status;
    data['message'] = message;
    data['status_code'] = statusCode;
    return data;
  }
}