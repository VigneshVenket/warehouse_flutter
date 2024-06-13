
part of 'get_currency_bloc.dart';

abstract class GetCurrencyState extends Equatable {
  const GetCurrencyState();
}

class GetCurrencyInitial extends GetCurrencyState {
  const GetCurrencyInitial();

  @override
  List<Object> get props => [];
}

class GetCurrencyLoading extends GetCurrencyState {
  const GetCurrencyLoading();

  @override
  List<Object> get props => [];
}

class GetCurrencyLoaded extends GetCurrencyState {
  final CurrenciesResponse currenciesResponse;

  const GetCurrencyLoaded(this.currenciesResponse);

  @override
  List<Object> get props => [currenciesResponse];
}

class GetCurrencyError extends GetCurrencyState {
  final String error;

  const GetCurrencyError(this.error);

  @override
  List<Object> get props => [error];
}
