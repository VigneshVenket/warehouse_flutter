

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/repos/order_shipment_cancel_repo.dart';

import 'order_shipment_cancel_event.dart';
import 'order_shipment_cancel_state.dart';

class OrderShipmentCancelBloc extends Bloc<OrderShipmentCancelEvent, OrderShipmentCancelState> {
  final OrderShipmentCancelRepo orderShipmentCancelRepo;

  OrderShipmentCancelBloc({required this.orderShipmentCancelRepo}) : super(OrderShipmentCancelInitial());

  @override
  Stream<OrderShipmentCancelState> mapEventToState(OrderShipmentCancelEvent event) async* {
    if (event is OrderShipmentCancelRequested) {
      yield OrderShipmentCancelLoading();
      try {
        final response =await orderShipmentCancelRepo.cancelOrderShipment(event.orderId, event.waybill);

        yield OrderShipmentCancelSuccess(response: response);
      } catch (e) {
        yield OrderShipmentCancelFailure(error: e.toString());
      }
    }
  }
}
