import 'package:flutter_kundol/models/statee.dart';

import '../constants/app_constants.dart';


class CountryyResponse {
  CountryyResponse({
    this.data,
    this.status,
    this.message,
    this.statusCode,
  });

  CountryyResponse.withError(String error) {
    data = null;
    status = AppConstants.STATUS_ERROR;
    message = error;
    statusCode = 0;
  }

  List<Countryy>? data;
  String? status;
  String? message;
  int? statusCode;

  factory CountryyResponse.fromJson(Map<String, dynamic> json) => CountryyResponse(
    data: List<Countryy>.from(json["data"].map((x) => Countryy.fromJson(x))),
    status: json["status"],
    message: json["message"],
    statusCode: json["status_code"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "status": status,
    "message": message,
    "status_code": statusCode,
  };
}

class Countryy {
  Countryy({
    this.countryId,
    this.countryName,
    this.isoCode2,
    this.isoCode3,
    this.addressFormatId,
    this.countryCode,
  });

  var countryId;
  String? countryName;
  String? isoCode2;
  String? isoCode3;
  String? addressFormatId;
  String? countryCode;

  factory Countryy.fromJson(Map<String, dynamic> json) => Countryy(
    countryId: json["country_id"],
    countryName: json["country_name"],
    isoCode2: json["iso_code_2"],
    isoCode3: json["iso_code_3"],
    addressFormatId: json["address_format_id"],
    countryCode: json["country_code"],
  );

  Map<String, dynamic> toJson() => {
    "country_id": countryId,
    "country_name": countryName,
    "iso_code_2": isoCode2,
    "iso_code_3": isoCode3,
    "address_format_id": addressFormatId,
    "country_code": countryCode,
  };
}
