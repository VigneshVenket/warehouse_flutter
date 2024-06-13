


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/constants/app_constants.dart';

import '../../repos/order_shipment_retutrn_repo.dart';
import 'order_shipment_return_event.dart';
import 'order_shipment_return_state.dart';


class OrderShipmentReturnBloc extends Bloc<OrderShipmentReturnEvent, OrderShipmentReturnState> {
  final OrderShipmentReturnRepo orderShipmentReturnRepo;

  OrderShipmentReturnBloc({required this.orderShipmentReturnRepo}) : super(OrderShipmentReturnInitial());

  @override
  Stream<OrderShipmentReturnState> mapEventToState(OrderShipmentReturnEvent event) async* {
    if (event is OrderShipmentReturnRequested) {
      yield OrderShipmentReturnLoading();
      try {
        final response =await orderShipmentReturnRepo.returnOrderShipment(event.orderStatus,
            event.orderReturnReason,
            event.orderReturnComment,
            event.returnAmount,
            event.returnImages,
            event.upiId, event.orderId, event.waybillNumber);
        if(response.status==AppConstants.STATUS_SUCCESS){
          yield OrderShipmentReturnSuccess(response: response);
        }else{
          yield OrderShipmentReturnFailure(error: response.message!);
        }

      } catch (e) {
        yield OrderShipmentReturnFailure(error: e.toString());
      }
    }
  }
}