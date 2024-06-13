

import '../../api/responses/shipment_track_response.dart';
import '../../models/shipment_track.dart';

abstract class ShipmentTrackState {}

class ShipmentTrackInitial extends ShipmentTrackState {}

class ShipmentTrackLoading extends ShipmentTrackState {}

class ShipmentTrackLoaded extends ShipmentTrackState {
  final List<ShipmentTrack> shipmentTrack;

  ShipmentTrackLoaded({required this.shipmentTrack});
}

class ShipmentTrackError extends ShipmentTrackState {

  final String errorMessage;

  ShipmentTrackError({required this.errorMessage});
}