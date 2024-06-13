import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/models/products/product.dart';

class ProductDetailResponse {
  Product? data;
  String? status;
  String? message;
  int? statusCode;

  ProductDetailResponse(
      {this.data, this.status, this.message, this.statusCode});

  ProductDetailResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Product.fromJson(json['data']) : null;
    status = json['status'];
    message = json['message'];
    statusCode = json['status_code'];
  }

  ProductDetailResponse.withError(String error) {
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
