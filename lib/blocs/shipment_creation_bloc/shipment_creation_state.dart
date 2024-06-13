

import '../../api/responses/shipment_creation_response.dart';

abstract class ShipmentCreateState {}

class ShipmentCreateInitialState extends ShipmentCreateState {}

class ShipmentCreateLoadingState extends ShipmentCreateState {}

class ShipmentCreateSuccessState extends ShipmentCreateState {
  final ShipmentCreateResponse response;

  ShipmentCreateSuccessState({required this.response});
}

class ShipmentCreateErrorState extends ShipmentCreateState {
  final String error;

  ShipmentCreateErrorState({required this.error});
}