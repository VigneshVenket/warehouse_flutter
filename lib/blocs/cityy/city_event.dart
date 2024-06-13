import 'package:equatable/equatable.dart';

abstract class CityyEvent extends Equatable {
  CityyEvent();
}

class GetCityy extends CityyEvent {
  final int? countryvalue;
  GetCityy(this.countryvalue);

  @override
  List<Object> get props => [countryvalue!];

  @override
  CityyEvent() {
    // TODO: implement WalleEvent
    throw UnimplementedError();
  }
}