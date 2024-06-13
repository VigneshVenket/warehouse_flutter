

import '../../models/shipment_track.dart';

// class ShipmentTrackResponse {
//   List<ShipmentTrack> ?shipmentData;
//
//   ShipmentTrackResponse({required this.shipmentData});
//
//   ShipmentTrackResponse.fromJson(Map<String,dynamic> json) {
//     // List<ShipmentTrack> shipmentData = json.map((data) => ShipmentTrack.fromJson(data['ShipmentData'])).toList();
//     // return ShipmentTrackResponse(shipmentData: shipmentData);
//
//     if (json['ShipmentData'] != null) {
//       shipmentData = <ShipmentTrack>[];
//       json['ShipmentData'].forEach((v) {
//         shipmentData?.add(ShipmentTrack.fromJson(v));
//       });
//     }
//   }
// }

class ShipmentTrackResponse {
  final List<ShipmentTrack> shipmentData;

  ShipmentTrackResponse({required this.shipmentData});

  factory ShipmentTrackResponse.fromJson(Map<String, dynamic> json) {
    var shipmentList = json['ShipmentData'] as List;
    List<ShipmentTrack> shipmentData =
    shipmentList.map((data) => ShipmentTrack.fromJson(data)).toList();

    return ShipmentTrackResponse(shipmentData: shipmentData);
  }
}