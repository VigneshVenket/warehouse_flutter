import 'package:flutter_kundol/api/api_provider.dart';
import 'package:flutter_kundol/api/responses/nearest_warehouse_response.dart';
import 'package:flutter_kundol/api/responses/orders_response.dart';

abstract class WarehouseRepo {

  Future<WarehouseResponse> getNearestWarehouse(String address);
}

class RealWarehouseRepo implements WarehouseRepo {

  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<WarehouseResponse> getNearestWarehouse(String address) {
    return _apiProvider.getNearestWarehouse(address);
  }
}