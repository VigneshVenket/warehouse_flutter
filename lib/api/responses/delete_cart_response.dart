import 'package:flutter_kundol/constants/app_constants.dart';

class DeleteCartResponse {
  String? status;
  String? message;
  String? data;

  DeleteCartResponse({this.status, this.message, this.data});

  DeleteCartResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'];
  }

  DeleteCartResponse.withError(String error) {
    status = AppConstants.STATUS_ERROR;
    message = error;
    data = null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['data'] = this.data;
    return data;
  }
}