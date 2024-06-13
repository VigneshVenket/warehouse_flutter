import 'package:equatable/equatable.dart';

import '../../models/wallet_data.dart';

abstract class WalletState extends Equatable {
  const WalletState();
}

class WalletInitial extends WalletState {
  const WalletInitial();

  @override
  List<Object> get props => [];
}

class WalletLoading extends WalletState {
  const WalletLoading();

  @override
  List<Object> get props => [];
}

class WalletLoaded extends WalletState {
  final List<wallet> walletData;

  const WalletLoaded(this.walletData);

  @override
  List<Object> get props => [walletData];
}

class WalletError extends WalletState {
  final String error;

  const WalletError(this.error);

  @override
  List<Object> get props => [error];
}
