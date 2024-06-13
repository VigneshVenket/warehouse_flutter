

abstract class ShipmentTrackEvent {}

class FetchShipmentTrack extends ShipmentTrackEvent {
  final String waybill;

  FetchShipmentTrack({required this.waybill});
}