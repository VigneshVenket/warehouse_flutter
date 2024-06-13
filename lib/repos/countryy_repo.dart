import 'package:flutter_kundol/api/api_provider.dart';
import '../models/countryy.dart';
import '../models/wallet_data.dart';
import 'package:flutter_kundol/api/responses/orders_response.dart';

abstract class CountryyRepo {
  Future<CountryyResponse> getCountryy();
}

class RealCountryyRepo implements CountryyRepo {

  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<CountryyResponse> getCountryy() {
    return _apiProvider.getCountryy();
  }

  @override
  Future<CountryyResponse> getCountry() {
    // TODO: implement getCountry
    throw UnimplementedError();
  }
}