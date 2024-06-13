import 'package:flutter_kundol/api/api_provider.dart';
import '../models/total_wallet_data.dart';
import '../models/wallet_data.dart';
import 'package:flutter_kundol/api/responses/orders_response.dart';

abstract class TotalRepo {
  Future<TotalResponse> getTotal();
}

class RealTotalRepo implements TotalRepo {

  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<TotalResponse> getTotal() {
    return _apiProvider.getTotal();
  }
}