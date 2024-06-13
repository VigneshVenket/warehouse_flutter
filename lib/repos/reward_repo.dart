
import 'package:flutter_kundol/api/api_provider.dart';
import 'package:flutter_kundol/api/responses/redeem_response.dart';
import 'package:flutter_kundol/api/responses/reward_point_response.dart';

abstract class RewardRepo {
  Future<RewardPointsResponse> getRewardPoints();
  Future<RedeemResponse> redeemRewardPoints();
}

class RealRewardPoints implements RewardRepo  {

  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<RewardPointsResponse> getRewardPoints() {
    return _apiProvider.getRewardPoints();
  }

  @override
  Future<RedeemResponse> redeemRewardPoints() {
    return _apiProvider.redeemRewardPoints();
  }
}
