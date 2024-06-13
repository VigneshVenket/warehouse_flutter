import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/models/category.dart';

class CategoriesResponse {
  List<Category>? data;
  String? status;
  String? message;
  int? statusCode;

  CategoriesResponse({required this.data, required this.status, required this.message, required this.statusCode});

  CategoriesResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Category.fromJson(v));
      });
    }
    status = json['status'];
    message = json['message'];
    statusCode = json['status_code'];
  }

  CategoriesResponse.withError(String error) {
    data = null;
    status = AppConstants.STATUS_ERROR;
    message = error;
    statusCode = 0;
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
