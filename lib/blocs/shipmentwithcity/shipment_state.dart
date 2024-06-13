

import 'package:equatable/equatable.dart';
import 'package:flutter_kundol/api/responses/shipment_city.dart';

abstract class ShipmentState extends Equatable {
  const ShipmentState();
}

class ShipmentInitial extends ShipmentState {
  const ShipmentInitial();

  @override
  List<Object> get props => [];
}

class ShipmentLoading extends ShipmentState {
  const ShipmentLoading(String? shippingCost);

  @override
  List<Object> get props => [];
}

class ShipmentLoaded extends ShipmentState {
  final  ShipmentCitysResponse shipmentData;

  const ShipmentLoaded(this.shipmentData);

  @override
  List<Object> get props => [shipmentData];
}

class ShipmentError extends ShipmentState {
  final String error;

  const ShipmentError(this.error);

  @override
  List<Object> get props => [error];
}

