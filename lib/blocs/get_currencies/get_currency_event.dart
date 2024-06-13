
part of 'get_currency_bloc.dart';

abstract class GetCurrencyEvent extends Equatable {
  const GetCurrencyEvent();
}

class GetCurrencies extends GetCurrencyEvent {
  const GetCurrencies();

  @override
  List<Object> get props => [];
}
