
import 'package:flutter_kundol/constants/app_constants.dart';

class RedeemResponse {
  String? status;
  String? message;

  RedeemResponse({this.status, this.message});

  RedeemResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  RedeemResponse.withError(String error){
    status = AppConstants.STATUS_ERROR;
    message = error;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}