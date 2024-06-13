import 'package:equatable/equatable.dart';

import '../../models/countryy.dart';
import '../../models/statee.dart';
import '../../models/wallet_data.dart';

abstract class StateeState extends Equatable {
  const StateeState();
}

class StateeInitial extends StateeState {
  const StateeInitial();

  @override
  List<Object> get props => [];
}

class StateeLoading extends StateeState {
  const StateeLoading();

  @override
  List<Object> get props => [];
}

class StateeLoaded extends StateeState {
  final List<Statee> stateeData;

  const StateeLoaded(this.stateeData);

  @override
  List<Object> get props => [stateeData];
}

class StateeError extends StateeState {
  final String error;

  const StateeError(this.error);

  @override
  List<Object> get props => [error];
}
