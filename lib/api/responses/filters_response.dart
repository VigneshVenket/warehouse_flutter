import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/models/filters_data.dart';

class FiltersResponse {
  List<FiltersData>? data;
  String? status;
  String? message;
  int? statusCode;

  FiltersResponse(
      {this.data,
        this.status,
        this.message,
        this.statusCode});

  FiltersResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <FiltersData>[];
      json['data'].forEach((v) {
        data?.add(FiltersData.fromJson(v));
      });
    }
    status = json['status'];
    message = json['message'];
    statusCode = json['status_code'];
  }

  FiltersResponse.withError(String error) {
    status = AppConstants.STATUS_ERROR;
    message = error;
    statusCode = 0;
    data = null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    data['message'] = message;
    data['status_code'] = statusCode;
    return data;
  }
}