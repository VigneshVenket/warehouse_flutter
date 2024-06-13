import 'package:equatable/equatable.dart';

import '../../models/cityy.dart';
import '../../models/countryy.dart';
import '../../models/wallet_data.dart';

abstract class CityyState extends Equatable {
  const CityyState();
}

class CityyInitial extends CityyState {
  const CityyInitial();

  @override
  List<Object> get props => [];
}

class CityyLoading extends CityyState {
  const CityyLoading();

  @override
  List<Object> get props => [];
}

class CityyLoaded extends CityyState {
  final List<Cityy> cityyData;

  const CityyLoaded(this.cityyData);

  @override
  List<Object> get props => [cityyData];

}

class CityyError extends CityyState {
  final String error;

  const CityyError(this.error);

  @override
  List<Object> get props => [error];
}
