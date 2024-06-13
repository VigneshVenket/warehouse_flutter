import 'package:equatable/equatable.dart';

abstract class WalletEvent extends Equatable {
   WalleEvent();
}

class GetWallet extends WalletEvent {

   GetWallet();

  @override
  List<Object> get props => [];

  @override
  WalleEvent() {
    // TODO: implement WalleEvent
    throw UnimplementedError();
  }
}