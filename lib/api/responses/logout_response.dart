import 'package:flutter_kundol/constants/app_constants.dart';

class LogoutResponse {
  String? status;
  String? message;

  LogoutResponse({this.status, this.message});

  LogoutResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  LogoutResponse.withError(String error){
    status = AppConstants.STATUS_ERROR;
    message = error;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}