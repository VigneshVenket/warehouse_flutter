import 'package:flutter_kundol/api/api_provider.dart';
import '../models/reward_des.dart';
import '../models/total_wallet_data.dart';
import '../models/wallet_data.dart';
import 'package:flutter_kundol/api/responses/orders_response.dart';

abstract class RewarddesRepo {
  Future<RewardDes> getRewarddes();
}

class RealRewarddesRepo implements RewarddesRepo {

  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<RewardDes> getRewarddes() {
    return _apiProvider.getRewarddes();
  }
}