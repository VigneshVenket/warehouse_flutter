

import 'package:equatable/equatable.dart';

abstract class ShippingCostEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchShippingCostEvent extends ShippingCostEvent {

  final String md;
  final String ss;
  final String dPin;
  final String oPin;
  final double cgm;
  final String pt;
  final double cod;

  FetchShippingCostEvent({
    required this.md,
    required this.ss,
    required this.dPin,
    required this.oPin,
    required this.cgm,
    required this.pt,
    required this.cod,
  });
}