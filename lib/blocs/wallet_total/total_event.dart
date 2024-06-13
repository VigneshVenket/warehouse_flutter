import 'package:equatable/equatable.dart';

abstract class TotalEvent extends Equatable {
  TotalEvent();
}

class GetTotal extends TotalEvent {

  GetTotal();

  @override
  List<Object> get props => [];

  @override
  TotalEvent() {
    // TODO: implement WalleEvent
    throw UnimplementedError();
  }
}