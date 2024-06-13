import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/models/PageData.dart';

class GetPageResponse {
  PageData? data;
  String? status;
  String? message;
  int? statusCode;

  GetPageResponse({this.data, this.status, this.message, this.statusCode});

  GetPageResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? PageData.fromJson(json['data']) : null;
    status = json['status'];
    message = json['message'];
    statusCode = json['status_code'];
  }

  GetPageResponse.withError(String error) {
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