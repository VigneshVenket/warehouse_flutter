import 'package:equatable/equatable.dart';

abstract class CountryyEvent extends Equatable {
  CountryyEvent();
}

class GetCountryy extends CountryyEvent {

  GetCountryy();

  @override
  List<Object> get props => [];

  @override
  CountryyEvent() {
    // TODO: implement WalleEvent
    throw UnimplementedError();
  }
}