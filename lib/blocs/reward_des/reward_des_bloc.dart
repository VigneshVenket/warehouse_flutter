import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/blocs/reward_des/reward_des_event.dart';
import 'package:flutter_kundol/blocs/reward_des/reward_des_state.dart';
import 'package:flutter_kundol/blocs/wallet/wallet_event.dart';
import 'package:flutter_kundol/blocs/wallet/wallet_state.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/models/orders_data.dart';
import 'package:flutter_kundol/repos/orders_repo.dart';

import '../../repos/reward_des_repo.dart';
import '../../repos/wallet_repo.dart';

class RewarddesBloc extends Bloc<RewarddesEvent, RewarddesState> {
  final RewarddesRepo rewarddesRepo;

  RewarddesBloc(this.rewarddesRepo) : super(RewarddesInitial());

  @override
  Stream<RewarddesState> mapEventToState(RewarddesEvent event) async* {
    if (event is GetRewarddes && AppData.user != null) {
      try {
        final rewarddesResponse = await rewarddesRepo.getRewarddes();
        if (rewarddesResponse.status == AppConstants.STATUS_SUCCESS &&
            rewarddesResponse.data != null)
          yield RewarddesLoaded(rewarddesResponse.data!);
        else
          yield RewarddesError(rewarddesResponse.message!);
      } on Error {
        yield RewarddesError("Couldn't fetch weather. Is the device online?");
      }
    }
  }
}
