import 'package:flutter_kundol/api/api_provider.dart';
import '../models/reward_points.dart';
import '../models/wallet_data.dart';
import 'package:flutter_kundol/api/responses/orders_response.dart';

abstract class RewardnRepo {
  Future<RewardnResponse> getRewardn();
}

class RealRewardnRepo implements RewardnRepo {

  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<RewardnResponse> getRewardn() {
    return _apiProvider.getRewardn();
  }

  @override
  Future<RewardnResponse> getWallet() {
    // TODO: implement getWallet
    throw UnimplementedError();
  }
}