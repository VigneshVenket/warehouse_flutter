

import 'package:equatable/equatable.dart';
import 'package:flutter_kundol/models/tax_data.dart';

abstract class TaxRateState extends Equatable {
  const TaxRateState();

  @override
  List<Object> get props => [];
}

class TaxRateInitial extends TaxRateState {}

class TaxRateLoading extends TaxRateState {}

class TaxRateLoaded extends TaxRateState {
  final List<TaxRateData> taxRates;

  const TaxRateLoaded(this.taxRates);

  @override
  List<Object> get props => [taxRates];
}

class TaxRateError extends TaxRateState {
  final String message;

  const TaxRateError(this.message);

  @override
  List<Object> get props => [message];
}
