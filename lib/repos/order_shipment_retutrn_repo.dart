


import 'dart:io';
import '../api/api_provider.dart';
import '../api/responses/order_shipment_return_response.dart';

abstract class OrderShipmentReturnRepo {
  Future<OrderShipmentReturnResponse> returnOrderShipment(
      String orderStatus,
      String orderReturnReason,
      String orderReturnComment,
      String returnAmount,
      List<File> returnImages,
      String upiId,
      int orderId,
      String waybillNumber);

}

class RealOrderShipmentReturnRepo implements OrderShipmentReturnRepo {
  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<OrderShipmentReturnResponse> returnOrderShipment(
      String orderStatus,
      String orderReturnReason,
      String orderReturnComment,
      String returnAmount,
      List<File> returnImages,
      String upiId,
      int orderId,
      String waybillNumber){
    return _apiProvider.returnOrderShipment(orderStatus, orderReturnReason, orderReturnComment, returnAmount, returnImages, upiId, orderId, waybillNumber);
  }

}