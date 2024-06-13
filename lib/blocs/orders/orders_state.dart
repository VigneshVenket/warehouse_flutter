part of 'orders_bloc.dart';

abstract class OrdersState extends Equatable {
  const OrdersState();
}

class OrdersInitial extends OrdersState {
  const OrdersInitial();

  @override
  List<Object> get props => [];
}

class OrdersLoading extends OrdersState {
  const OrdersLoading();

  @override
  List<Object> get props => [];
}

class OrdersLoaded extends OrdersState {
  final List<OrdersData> ordersData;

  const OrdersLoaded(this.ordersData);

  @override
  List<Object> get props => [ordersData];
}

class OrdersError extends OrdersState {
  final String error;

  const OrdersError(this.error);

  @override
  List<Object> get props => [error];
}
