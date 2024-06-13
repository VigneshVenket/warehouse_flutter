part of 'orders_bloc.dart';

abstract class OrdersEvent extends Equatable {
  const OrdersEvent();
}

class GetOrders extends OrdersEvent {
  const GetOrders();

  @override
  List<Object> get props => [];
}

abstract class OrdersEvent1 extends Equatable {
  const OrdersEvent1();
}

class GetOrders1 extends OrdersEvent1 {
  final int? OrderId;
  const GetOrders1(this.OrderId);

  @override
  List<Object> get props => [OrderId!];
}
