import 'package:equatable/equatable.dart';

import '../../models/reward_des.dart';
import '../../models/wallet_data.dart';

abstract class RewarddesState extends Equatable {
  const RewarddesState();
}

class RewarddesInitial extends RewarddesState {
  const RewarddesInitial();

  @override
  List<Object> get props => [];
}

class RewarddesLoading extends RewarddesState {
  const RewarddesLoading();

  @override
  List<Object> get props => [];
}

class RewarddesLoaded extends RewarddesState {
  final List<Datum> rewarddesData;

  const RewarddesLoaded(this.rewarddesData);

  @override
  List<Object> get props => [rewarddesData];
}

class RewarddesError extends RewarddesState {
  final String error;

  const RewarddesError(this.error);

  @override
  List<Object> get props => [error];
}
