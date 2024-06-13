import 'package:flutter_kundol/constants/app_constants.dart';

class OrderShipmentCancelResponse {
  String? status;
  String ?message;
  int ?code;

  OrderShipmentCancelResponse({
    required this.status,
    required this.message,
    required this.code,
  });

  factory OrderShipmentCancelResponse.fromJson(Map<String, dynamic> json) {
    return OrderShipmentCancelResponse(
      status: json['status'],
      message: json['message'],
      code: json['code'],
    );
  }

  OrderShipmentCancelResponse.withError(String error){
     status=AppConstants.STATUS_ERROR;
     message=error;
     code=0;
  }

}
