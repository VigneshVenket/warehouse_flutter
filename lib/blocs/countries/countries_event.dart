import 'package:equatable/equatable.dart';

abstract class CountriesEvent extends Equatable {
  const CountriesEvent();
}

class GetCountries extends CountriesEvent {
  const GetCountries();

  @override
  List<Object> get props => [];
}
