import '../constants/app_constants.dart';

class StateeResponse {
  StateeResponse({
    this.data,
    this.status,
    this.message,
    this.statusCode,
  });

  List<Statee>? data;
  String? status;
  String? message;
  int? statusCode;

  factory StateeResponse.fromJson(Map<String, dynamic> json) => StateeResponse(
    data: List<Statee>.from(json["data"].map((x) => Statee.fromJson(x))),
    status: json["status"],
    message: json["message"],
    statusCode: json["status_code"],
  );

  StateeResponse.withError(String error) {
    data = null;
    status = AppConstants.STATUS_ERROR;
    message = error;
    statusCode = 0;
  }

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "status": status,
    "message": message,
    "status_code": statusCode,
  };
}

class Statee {
  Statee({
    this.id,
    this.name,
    this.countryId,
  });

  var id;
  String? name;
  var countryId;

  factory Statee.fromJson(Map<String, dynamic> json) => Statee(
    id: json["id"],
    name: json["name"],
    countryId: json["country_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "country_id": countryId,
  };
}
