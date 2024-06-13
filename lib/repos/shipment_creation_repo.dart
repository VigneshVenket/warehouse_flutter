

import 'package:flutter_kundol/api/responses/shipment_creation_response.dart';
import 'package:flutter_kundol/models/shipment_creation.dart';

import '../api/api_provider.dart';

abstract class ShipmentCreationRepo {

  Future<ShipmentCreateResponse> shipmentCreation(ShipmentCreateData shipmentCreateData);
}

class RealShipmentCreationRepo implements ShipmentCreationRepo {

  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<ShipmentCreateResponse> shipmentCreation(ShipmentCreateData shipmentCreateData) {
    return _apiProvider.shipmentCreation(shipmentCreateData);
  }
}