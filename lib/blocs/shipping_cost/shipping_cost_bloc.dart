
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/blocs/shipping_cost/shipping_cost_event.dart';
import 'package:flutter_kundol/blocs/shipping_cost/shipping_cost_state.dart';
import 'package:flutter_kundol/repos/shipping_cost_repo.dart';

import '../../api/responses/shipping_cost_response.dart';

class ShippingCostBloc extends Bloc<ShippingCostEvent, ShippingCostState> {

  final ShippingCostRepo shippingCostRepo;

  ShippingCostBloc(this.shippingCostRepo):super(ShippingCostInitialState());


  @override
  ShippingCostState get initialState => ShippingCostInitialState();

  @override
  Stream<ShippingCostState> mapEventToState(ShippingCostEvent event) async* {
    if (event is FetchShippingCostEvent) {
      yield ShippingCostInitialState();

      try {
          final shippingCostResponse= await shippingCostRepo.getShippingCost(event.md,event.ss, event.dPin, event.oPin, event.cgm, event.pt, event.cod);

          yield ShippingCostLoadedState(shippingCostResponse: shippingCostResponse);

      } catch (e) {
        yield ShippingCostErrorState(error: e.toString());
      }
    }
  }
}