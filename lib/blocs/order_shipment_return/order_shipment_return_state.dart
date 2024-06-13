




import '../../api/responses/order_shipment_return_response.dart';

abstract class OrderShipmentReturnState {
  const OrderShipmentReturnState();

}

class OrderShipmentReturnInitial extends OrderShipmentReturnState {}

class OrderShipmentReturnLoading extends OrderShipmentReturnState {}

class OrderShipmentReturnSuccess extends OrderShipmentReturnState {
  final OrderShipmentReturnResponse response;

  const OrderShipmentReturnSuccess({required this.response});

}

class OrderShipmentReturnFailure extends OrderShipmentReturnState {
  final String error;

  const OrderShipmentReturnFailure({required this.error});

}