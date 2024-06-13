


import '../api/api_provider.dart';
import '../api/responses/tax_response.dart';

abstract class TaxRepo {

  Future<TaxRateResponse> getTax(int stateId);
}

class RealTaxRepo implements TaxRepo {

  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<TaxRateResponse> getTax(int stateId) {
    return _apiProvider.getTax(stateId);
  }
}