import '../constants/app_constants.dart';

class CityyResponse {
  CityyResponse({
    this.data,
    this.status,
    this.message,
    this.statusCode,
  });

  List<Cityy>? data;
  String? status;
  String? message;
  int? statusCode;

  factory CityyResponse.fromJson(Map<String, dynamic> json) => CityyResponse(
    data: List<Cityy>.from(json["data"].map((x) => Cityy.fromJson(x))),
    status: json["status"],
    message: json["message"],
    statusCode: json["status_code"],
  );

  CityyResponse.withError(String error) {
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

class Cityy {
  Cityy({
    this.id,
    this.name,
    this.stateId,
    this.countryId,
  });

  var id;
  String? name;
  var stateId;
  var countryId;

  factory Cityy.fromJson(Map<String, dynamic> json) => Cityy(
    id: json["id"],
    name: json["name"],
    stateId: json["state_id"],
    countryId: json["country_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "state_id": stateId,
    "country_id": countryId,
  };
}
