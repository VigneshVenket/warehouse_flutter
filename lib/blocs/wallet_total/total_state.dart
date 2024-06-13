import 'package:equatable/equatable.dart';

import '../../models/wallet_data.dart';
import '../wallet/wallet_state.dart';

abstract class TotalState extends Equatable {
   TotaltState();
}

class TotalInitial extends TotalState {
   TotalInitial();

  @override
  List<Object> get props => [];

  @override
  TotaltState() {
    // TODO: implement TotaltState
    throw UnimplementedError();
  }
}

class TotalLoading extends TotalState {
  TotalLoading();

  @override
  List<Object> get props => [];

  @override
  TotaltState() {
    // TODO: implement TotaltState
    throw UnimplementedError();
  }
}

class TotalLoaded extends TotalState {
  final List totalData;
   TotalLoaded(this.totalData);

  @override
  List<Object> get props => [totalData];

  @override
  TotaltState() {
    // TODO: implement TotaltState
    throw UnimplementedError();
  }
}

class TotalError extends TotalState {
  final String error;

   TotalError(this.error);

  @override
  List<Object> get props => [error];

  @override
  TotaltState() {
    // TODO: implement TotaltState
    throw UnimplementedError();
  }
}
