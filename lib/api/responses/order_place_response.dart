import 'package:flutter_kundol/constants/app_constants.dart';

import 'package:flutter_kundol/constants/app_constants.dart';

import '../../models/order_id.dart';

// class OrderPlaceResponse {
//   OrderId? data;
//   // String? status;
//   // String? message;
//   // int? statusCode;
//
//   OrderPlaceResponse({this.data});
//
//   OrderPlaceResponse.fromJson(Map<String, dynamic> json) {
//     if (json['data'] != null) {
//       data = OrderId.fromJson(json['order']);
//     }
//     // status = json['status'];
//     // message = json['message'];
//     // statusCode = json['status_code'];
//   }
//
//   // OrderPlaceResponse.withError(String error){
//   //   status = AppConstants.STATUS_ERROR;
//   //   message = error;
//   //   statusCode = 0;
//   // }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> value = <String, dynamic>{};
//     value['order']=data;
//     // value['status'] = status;
//     // value['message'] = message;
//     // value['status_code'] = statusCode;
//     return value;
//   }
// }

// class OrderPlaceResponse {
//   String? status;
//   String? message;
//   int? statusCode;
//
//   OrderPlaceResponse({this.status, this.message, this.statusCode});
//
//   OrderPlaceResponse.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     statusCode = json['status_code'];
//   }
//
//   OrderPlaceResponse.withError(String error){
//     status = AppConstants.STATUS_ERROR;
//     message = error;
//     statusCode = 0;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['status'] = status;
//     data['message'] = message;
//     data['status_code'] = statusCode;
//     return data;
//   }
// }


class OrderPlaceResponse {
  String? status;
  Order? order;
  List<Shipment>? shipment;
  String? messsage;
  int? code;

  OrderPlaceResponse({
    required this.status,
    required this.order,
    required this.shipment,
    required this.messsage,
    required this.code

  });

  factory OrderPlaceResponse.fromJson(Map<String, dynamic> json) {
    return OrderPlaceResponse(
      status: json['status'],
      order: Order.fromJson(json['order']),
      shipment: List<Shipment>.from(
          json['shipment'].map((shipmentJson) => Shipment.fromJson(shipmentJson))
      ),
      messsage: json['message'],
      code: json['code']
    );
  }

  OrderPlaceResponse.withError(String error){
    status=AppConstants.STATUS_ERROR;
    order=null;
    shipment=null;
    messsage=error;
    code=0;
  }
}
