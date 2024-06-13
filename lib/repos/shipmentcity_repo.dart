import 'package:flutter_kundol/api/api_provider.dart';

import '../api/responses/shipment_city.dart';

abstract class CityRepo {
  Future<ShipmentCitysResponse> getShipment(String city);
  
}
class RealShipmentRepo implements CityRepo {
  ApiProvider apiProvider = ApiProvider();
  @override
  Future<ShipmentCitysResponse> getShipment(String city,) {
    return apiProvider.getShipment(city);
  }
}
  class FakeCityRepo implements CityRepo {
  @override
  Future<ShipmentCitysResponse> getShipment(String city) {
    throw UnimplementedError();
  }
  }