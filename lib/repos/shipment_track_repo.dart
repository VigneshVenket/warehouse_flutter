


import 'package:flutter_kundol/api/responses/shipment_track_response.dart';

import '../api/api_provider.dart';

abstract class ShipmentTrackRepo {

  Future<ShipmentTrackResponse> getShipmentTrack(String waybill);
}

class RealShipmentTrackRepo implements ShipmentTrackRepo {

  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<ShipmentTrackResponse> getShipmentTrack(String waybill) {
    return _apiProvider.getShipmentTrack(waybill);
  }
}