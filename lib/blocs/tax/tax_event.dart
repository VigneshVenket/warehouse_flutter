


import 'package:equatable/equatable.dart';

abstract class TaxRateEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchTaxRate extends TaxRateEvent {
  final int stateId;

  FetchTaxRate(this.stateId);

  @override
  List<Object> get props => [stateId];
}
