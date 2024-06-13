import 'package:flutter_kundol/api/api_provider.dart';
import 'package:flutter_kundol/api/responses/currencies_response.dart';

abstract class GetCurrencyRepo {
  Future<CurrenciesResponse> fetchCurrencies();
}

class RealGetCurrencyRepo implements GetCurrencyRepo {
  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<CurrenciesResponse> fetchCurrencies() {
    return _apiProvider.getCurrencies();
  }
}

class FakeBannersRepo implements GetCurrencyRepo {
  @override
  Future<CurrenciesResponse> fetchCurrencies() {
    throw UnimplementedError();
  }
}
