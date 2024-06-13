



import 'package:equatable/equatable.dart';

import '../../api/responses/order_shipment_cancel_response.dart';


abstract class OrderShipmentCancelState {
  const OrderShipmentCancelState();

}

class OrderShipmentCancelInitial extends OrderShipmentCancelState {}

class OrderShipmentCancelLoading extends OrderShipmentCancelState {}

class OrderShipmentCancelSuccess extends OrderShipmentCancelState {
  final OrderShipmentCancelResponse response;

  const OrderShipmentCancelSuccess({required this.response});

}

class OrderShipmentCancelFailure extends OrderShipmentCancelState {
  final String error;

  const OrderShipmentCancelFailure({required this.error});

}
