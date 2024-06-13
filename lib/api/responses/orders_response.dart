import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/models/orders_data.dart';

class OrdersResponse {
  List<OrdersData>? data;
  String? status;
  String? message;
  int? statusCode;

  OrdersResponse(
      {this.data,
        this.status,
        this.message,
        this.statusCode});

  OrdersResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <OrdersData>[];
      json['data'].forEach((v) {
        data?.add(OrdersData.fromJson(v));
      });
    }
    status = json['status'];
    message = json['message'];
    statusCode = json['status_code'];
  }

  OrdersResponse.withError(String error) {
    data = null;
    statusCode =0;
    status = AppConstants.STATUS_ERROR;
    message = error;
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