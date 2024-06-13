import 'package:flutter_kundol/models/tax_data.dart';

// class TaxResponse {
//   final List<TaxRateData> data;
//   final String status;
//   final String message;
//   final int statusCode;
//
//   TaxResponse({
//     required this.data,
//     required this.status,
//     required this.message,
//     required this.statusCode,
//   });
//
//   factory TaxResponse.fromJson(Map<String, dynamic> json) {
//     var dataList = json['data'] as List;
//     List<TaxRateData> data =
//     dataList.map((datumJson) => TaxRateData.fromJson(datumJson)).toList();
//
//     return TaxResponse(
//       data: data,
//       status: json['status'],
//       message: json['message'],
//       statusCode: json['statusCode'],
//     );
//   }
// }


import 'dart:convert';

class TaxRateResponse {
  List<TaxRateData> data;
  String status;
  String message;
  int statusCode;

  TaxRateResponse({
    required this.data,
    required this.status,
    required this.message,
    required this.statusCode,
  });

  factory TaxRateResponse.fromJson(Map<String, dynamic> json) =>
      TaxRateResponse(
        data: List<TaxRateData>.from(
            json["data"].map((x) => TaxRateData.fromJson(x))),
        status: json["status"],
        message: json["message"],
        statusCode: json["status_code"],
      );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "status": status,
    "message": message,
    "status_code": statusCode,
  };
}
