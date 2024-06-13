import 'package:flutter_kundol/api/api_provider.dart';
import '../models/countryy.dart';
import '../models/statee.dart';
import '../models/wallet_data.dart';
import 'package:flutter_kundol/api/responses/orders_response.dart';

abstract class StateeRepo {
  Future<StateeResponse> getStatee(int? value);
}

class RealStateeRepo implements StateeRepo {

  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<StateeResponse> getStatee(int? value) {
    return _apiProvider.getStatee(value);
  }

  @override
  Future<StateeResponse> getStateee() {
    // TODO: implement getCountry
    throw UnimplementedError();
  }
}