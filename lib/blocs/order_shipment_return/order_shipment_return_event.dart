
import 'dart:io';

abstract class OrderShipmentReturnEvent{
  const OrderShipmentReturnEvent();
}

class OrderShipmentReturnRequested extends OrderShipmentReturnEvent {
   final  String orderStatus;
   final  String orderReturnReason;
   final  String orderReturnComment;
   final  String returnAmount;
   final  List<File> returnImages;
   final  String upiId;
   final  int orderId;
   final  String waybillNumber;

  const OrderShipmentReturnRequested({
    required this.orderStatus,
    required this.orderReturnReason,
    required this.orderReturnComment,
    required this.returnAmount,
    required this.returnImages,
    required this.upiId,
    required this.orderId,
    required this.waybillNumber
  });

}