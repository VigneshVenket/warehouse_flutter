import 'package:flutter_kundol/api/api_provider.dart';
import '../models/cityy.dart';
import '../models/countryy.dart';
import '../models/wallet_data.dart';
import 'package:flutter_kundol/api/responses/orders_response.dart';

abstract class CityyRepo {
  Future<CityyResponse> getCityy(int? countryvalue);
}

class RealCityyRepo implements CityyRepo {

  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<CityyResponse> getCityy(int?countryvalue) {
    return _apiProvider.getCityy(countryvalue);
  }

}