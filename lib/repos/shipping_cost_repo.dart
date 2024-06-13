
import 'package:flutter_kundol/api/responses/shipping_cost_response.dart';

import '../api/api_provider.dart';

abstract class ShippingCostRepo {

  Future<ShippingCostResponse> getShippingCost(String md,String ss,String dPin,String oPin,double cgm,String pt,double cod);
}

class RealShippingCostRepo implements ShippingCostRepo {

  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<ShippingCostResponse> getShippingCost(String md,String ss,String dPin,String oPin,double cgm,String pt,double cod) {
       return _apiProvider.getShippingCost(md, ss, dPin, oPin, cgm, pt, cod);
  }
}