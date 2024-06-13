import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/models/orders_data.dart';
import 'package:flutter_kundol/repos/orders_repo.dart';

part 'orders_event.dart';

part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final OrdersRepo ordersRepo;

  OrdersBloc(this.ordersRepo) : super(OrdersInitial());

  @override
  Stream<OrdersState> mapEventToState(OrdersEvent event) async* {
    if (event is GetOrders && AppData.user != null) {
      try {
        final ordersResponse = await ordersRepo.getOrders();
        if (ordersResponse.status == AppConstants.STATUS_SUCCESS &&
            ordersResponse.data != null)
          yield OrdersLoaded(ordersResponse.data!);
        else
          yield OrdersError(ordersResponse.message!);
      } on Error {
        yield OrdersError("Couldn't fetch weather. Is the device online?");
      }
    }
  }

  Stream<OrdersState> mapEventToState1(OrdersEvent1 event) async* {
    if (event is GetOrders1 && AppData.user != null) {
      try {
        final ordersResponse = await ordersRepo.getOrderById(event.OrderId!);
        if (ordersResponse.status == AppConstants.STATUS_SUCCESS &&
            ordersResponse.data != null)
          yield OrdersLoaded(ordersResponse.data!);
        else
          yield OrdersError(ordersResponse.message!);
      } on Error {
        yield OrdersError("Couldn't fetch weather. Is the device online?");
      }
    }
  }
}
