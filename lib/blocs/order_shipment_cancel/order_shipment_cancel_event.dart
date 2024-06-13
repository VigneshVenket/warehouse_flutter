

import 'package:equatable/equatable.dart';

abstract class OrderShipmentCancelEvent{
  const OrderShipmentCancelEvent();
}

class OrderShipmentCancelRequested extends OrderShipmentCancelEvent {
  final int orderId;
  final String waybill;

  const OrderShipmentCancelRequested({
    required this.orderId,
    required this.waybill,
  });

}
