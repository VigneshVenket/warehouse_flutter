import 'package:flutter_kundol/constants/app_constants.dart';

class AddReviewResponse {
  String? status;
  String? message;
  int? statusCode;

  AddReviewResponse({this.status, this.message, this.statusCode});

  AddReviewResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    statusCode = json['status_code'];
  }

  AddReviewResponse.withError(String error) {
    status = AppConstants.STATUS_ERROR;
    message = error;
    statusCode = 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['status_code'] = statusCode;
    return data;
  }
}