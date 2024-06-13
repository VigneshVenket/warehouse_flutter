import 'dart:convert';

import '../constants/app_constants.dart';

class TotalResponse {
  TotalResponse({
    this.status,
    this.message,
    this.data,
    this.statusCode,
  });

  String? status;
  String? message;
  var data;
  int? statusCode;

  factory TotalResponse.fromJson(Map<String, dynamic> json) => TotalResponse(
    status: json["status"],
    message: json["message"],
    data: json["data"],
  );

  TotalResponse.withError(String error) {
    data = null;
    status = AppConstants.STATUS_ERROR;
    message = error;
    statusCode = 0;
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data,
  };
}
