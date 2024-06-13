
part of 'currency_bloc.dart';

class CurrencyState extends Equatable {
  final CurrencyData currency;
  const CurrencyState(this.currency) : assert(currency != null);

  @override
  List<Object> get props => [currency];
}