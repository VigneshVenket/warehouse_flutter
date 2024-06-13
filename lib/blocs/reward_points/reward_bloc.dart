import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/api/responses/redeem_response.dart';
import 'package:flutter_kundol/api/responses/reward_point_response.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/repos/reward_repo.dart';

part 'reward_event.dart';

part 'reward_state.dart';

class RewardBloc extends Bloc<RewardEvent, RewardState> {
  final RewardRepo rewardRepo;

  RewardBloc(this.rewardRepo) : super(const RewardInitial());

  @override
  Stream<RewardState> mapEventToState(RewardEvent event) async* {
    RewardPointsResponse? rewardResponse;
    if (event is GetRewardPoints) {
      try {
        rewardResponse = await rewardRepo.getRewardPoints();
        if (rewardResponse.status == AppConstants.STATUS_SUCCESS &&
            rewardResponse.data != null) {
          yield RewardLoaded(rewardResponse);
        } else {
          yield RewardError(rewardResponse.message!);
        }
      } on Error {
        yield const RewardError("Couldn't fetch weather. Is the device online?");
      }
    } else if (event is RedeemPoints) {
      try {
        final redeemResponse = await rewardRepo.redeemRewardPoints();
        if (redeemResponse.status == AppConstants.STATUS_SUCCESS) {
          yield RedeemLoaded(redeemResponse, rewardResponse!);
        } else {
          yield RewardError(redeemResponse.message!);
        }
      } on Error {
        yield const RewardError("Couldn't fetch weather. Is the device online?");
      }
    }
  }
}
