
import 'package:equatable/equatable.dart';

import '../../constants/app_constants.dart';
import '../../models/nearest_warehouse.dart';


class WarehouseResponse{

  Warehouse? data;
  String ?status;
  String ?message;

  WarehouseResponse({
    required this.data,
    required this.status,
    required this.message,
  });

  factory WarehouseResponse.fromJson(Map<String, dynamic> json) {
    return WarehouseResponse(
      data: Warehouse.fromJson(json['data']),
      status: json['status'],
      message: json['message'],
    );
  }

  WarehouseResponse.withError(String error) {
    status = AppConstants.STATUS_ERROR;
    data = null;
    message = error ;
  }
}