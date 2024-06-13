


import 'package:flutter_kundol/api/responses/order_shipment_cancel_response.dart';

import '../api/api_provider.dart';

abstract class OrderShipmentCancelRepo {
  Future<OrderShipmentCancelResponse> cancelOrderShipment(int orderId,String waybill);

}

class RealOrderShipmentCancelRepo implements OrderShipmentCancelRepo {
  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<OrderShipmentCancelResponse> cancelOrderShipment(int orderId,String waybill) {
    return _apiProvider.cancelOrderShipment(orderId, waybill);
  }


}