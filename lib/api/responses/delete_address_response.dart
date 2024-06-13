import 'package:flutter_kundol/constants/app_constants.dart';

class DeleteAddressResponse {
  String? status;
  String? message;
  String? data;

  DeleteAddressResponse({this.status, this.message, this.data});

  DeleteAddressResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'];
  }

  DeleteAddressResponse.withError(String error) {
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