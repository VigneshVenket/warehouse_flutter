
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/blocs/rewards/rewards_event.dart';
import 'package:flutter_kundol/blocs/rewards/rewards_state.dart';

import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import '../../repos/rewards_repo.dart';
import '../reward_points/reward_bloc.dart';


class RewardnBloc extends Bloc<RewardnEvent, RewardnState> {
  final RewardnRepo rewardnRepo;

  RewardnBloc(this.rewardnRepo) : super(RewardnInitial());

  @override
  Stream<RewardnState> mapEventToState(RewardnEvent event) async* {
    if (event is GetRewardn && AppData.user != null) {
      try {
        final rewardnResponse = await rewardnRepo.getRewardn();
        if (rewardnResponse.status == AppConstants.STATUS_SUCCESS &&
            rewardnResponse.data != null)
          yield RewardnLoaded(rewardnResponse.data!);
        else
          yield RewardnError(rewardnResponse.message!);
      } on Error {
        yield RewardnError("Couldn't fetch weather. Is the device online?");
      }
    }
  }
}
