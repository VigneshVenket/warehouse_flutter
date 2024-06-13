


import '../../constants/app_constants.dart';

class OrderShipmentReturnResponse {
  String? status;
  String ?message;
  int ?code;

  OrderShipmentReturnResponse({
    required this.status,
    required this.message,
    required this.code,
  });

  factory OrderShipmentReturnResponse.fromJson(Map<String, dynamic> json) {
    return OrderShipmentReturnResponse(
      status: json['status'],
      message: json['message'],
      code: json['code'],
    );
  }

  OrderShipmentReturnResponse.withError(String error){
    status=AppConstants.STATUS_ERROR;
    message=error;
    code=0;
  }

}