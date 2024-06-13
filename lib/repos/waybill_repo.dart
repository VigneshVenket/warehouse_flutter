

import 'package:flutter_kundol/api/responses/shipping_cost_response.dart';

import '../api/api_provider.dart';
import '../api/responses/waybill_response.dart';

abstract class WaybillRepo {

  Future<WaybillResponse> getWaybill();
}

class RealWaybillRepo implements WaybillRepo {

  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<WaybillResponse> getWaybill() {
     return _apiProvider.getWaybill();
  }


}