import 'package:flutter_kundol/api/api_provider.dart';
import '../models/wallet_data.dart';
import 'package:flutter_kundol/api/responses/orders_response.dart';

abstract class WalletRepo {
  Future<WalletResponse> getWallet();
}

class RealWalletRepo implements WalletRepo {

  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<WalletResponse> getWallet() {
    return _apiProvider.getWallet();
  }
}