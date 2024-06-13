



import 'package:equatable/equatable.dart';

import '../../api/responses/shipping_cost_response.dart';
import '../../models/shipping_cost.dart';

abstract class ShippingCostState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ShippingCostInitialState extends ShippingCostState {}

class ShippingCostLoadedState extends ShippingCostState {
   final ShippingCostResponse shippingCostResponse;

   ShippingCostLoadedState({required this.shippingCostResponse});
}

class ShippingCostErrorState extends ShippingCostState {
  final String error;

  ShippingCostErrorState({required this.error});
}