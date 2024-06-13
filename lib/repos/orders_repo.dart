import 'package:flutter_kundol/api/api_provider.dart';
import 'package:flutter_kundol/api/responses/orders_response.dart';

abstract class OrdersRepo {
  Future<OrdersResponse> getOrders();

  Future<OrdersResponse> getOrderById(int id);
}

class RealOrdersRepo implements OrdersRepo {
  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<OrdersResponse> getOrders() {
    return _apiProvider.getOrders();
  }

  Future<OrdersResponse> getOrderById(int Id) {
    return _apiProvider.getOrderById(Id);
  }
}
