import 'package:flutter_kundol/constants/app_constants.dart';

class UpdateProfileAddressResponse {
  String? status;
  String? message;
  int? statusCode;

  UpdateProfileAddressResponse({ this.status, this.message, this.statusCode});

  UpdateProfileAddressResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    statusCode = json['status_code'];
  }

  UpdateProfileAddressResponse.withError(String error) {
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