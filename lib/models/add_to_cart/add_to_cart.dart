import 'package:flutter_kundol/constants/app_constants.dart';

class AddToCartResponse {
  AddToCartData? data;
  String? status;
  String? message;
  int? statusCode;

  AddToCartResponse({ required this.data,   required this.status,   required this.message,  required this.statusCode});

  AddToCartResponse.fromJson(Map<String, dynamic> json) {
    data = (json['data'] != null ? AddToCartData.fromJson(json['data']) : null);
    status = json['status'];
    message = json['message'];
    statusCode = json['status_code'];
  }

  AddToCartResponse.withError(String error) {
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

class AddToCartData {
  String? session;

  AddToCartData({required this.session});

  AddToCartData.fromJson(Map<String, dynamic> json) {
    session = json['session'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['session'] = session;
    return data;
  }
}
