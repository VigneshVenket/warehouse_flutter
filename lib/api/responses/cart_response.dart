import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/models/cart_data.dart';

import '../../constants/app_cart.dart';

class CartResponse {
  List<CartData>? data;
  String? status;
  String? message;
  int? statusCode;

  CartResponse({this.data, this.status, this.message, this.statusCode});

  CartResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CartData>[];
      json['data'].forEach((v) {
        data?.add(CartData.fromJson(v));
      });
    }
    print("print cart");
    print(json['data']);
    var s1 = AppBadge();
    s1.BadgeUpdate(data?.length??0);
    print("-------------------------------------------- updated card----------------------- ${data?.length}" );
    status = json['status'];
    message = json['message'];
    statusCode = json['status_code'];
  }

  CartResponse.withError(String error){
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
