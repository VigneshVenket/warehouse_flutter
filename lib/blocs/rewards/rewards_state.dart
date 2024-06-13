import 'package:equatable/equatable.dart';

import '../../models/reward_points.dart';
import '../../models/wallet_data.dart';

abstract class RewardnState extends Equatable {
  const RewardnState();
}

class RewardnInitial extends RewardnState {
  const RewardnInitial();

  @override
  List<Object> get props => [];
}

class RewardnLoading extends RewardnState {
  const RewardnLoading();

  @override
  List<Object> get props => [];
}

class RewardnLoaded extends RewardnState {
  final double rewardnData;

  const RewardnLoaded(this.rewardnData);

  @override
  List<Object> get props => [rewardnData];
}

class RewardnError extends RewardnState {
  final String error;

  const RewardnError(this.error);

  @override
  List<Object> get props => [error];
}
