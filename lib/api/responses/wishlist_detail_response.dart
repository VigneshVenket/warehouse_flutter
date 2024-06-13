import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/models/wishlistDetailData.dart';

class WishlistDetailResponse {
  List<WishlistDetailData>? data;
  String? status;
  String? message;
  int? statusCode;

  WishlistDetailResponse(
      {this.data,
        this.status,
        this.message,
        this.statusCode});

  WishlistDetailResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <WishlistDetailData>[];
      json['data'].forEach((v) {
        data?.add(WishlistDetailData.fromJson(v));
      });
    }
    status = json['status'];
    message = json['message'];
    statusCode = json['status_code'];
  }

  WishlistDetailResponse.withError(String error) {
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