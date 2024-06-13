import 'package:equatable/equatable.dart';

import '../../models/countryy.dart';
import '../../models/wallet_data.dart';

abstract class CountryyState extends Equatable {
  const CountryyState();
}

class CountryyInitial extends CountryyState {
  const CountryyInitial();

  @override
  List<Object> get props => [];
}

class CountryyLoading extends CountryyState {
  const CountryyLoading();

  @override
  List<Object> get props => [];
}

class CountryyLoaded extends CountryyState {
  final List<Countryy> countryyData;

  const CountryyLoaded(this.countryyData);

  @override
  List<Object> get props => [countryyData];

}

class CountryyError extends CountryyState {
  final String error;

  const CountryyError(this.error);

  @override
  List<Object> get props => [error];
}
