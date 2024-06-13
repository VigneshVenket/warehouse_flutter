


import '../../models/shipment_creation.dart';

abstract class ShipmentCreateEvent {}

class PostShipmentCreateEvent extends ShipmentCreateEvent {
  final ShipmentCreateData shipmentCreateData;

  PostShipmentCreateEvent({required this.shipmentCreateData});
}