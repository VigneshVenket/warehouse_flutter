

import 'package:equatable/equatable.dart';
import 'package:flutter_kundol/api/responses/waybill_response.dart';

import '../../api/responses/shipping_cost_response.dart';
import '../../models/shipping_cost.dart';

abstract class WaybillState extends Equatable {
  @override
  List<Object?> get props => [];
}

class WaybillInitialState extends WaybillState {}

class WaybillLoadedState extends WaybillState {
  final WaybillResponse waybillResponse;

  WaybillLoadedState({required this.waybillResponse});

}

class WaybillErrorState extends WaybillState {
  final String error;

  WaybillErrorState({required this.error});
}