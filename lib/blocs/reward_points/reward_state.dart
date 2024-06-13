part of 'reward_bloc.dart';

abstract class RewardState extends Equatable {
  const RewardState();
}

class RewardInitial extends RewardState {
  const RewardInitial();

  @override
  List<Object> get props => [];
}

class RewardLoading extends RewardState {
  const RewardLoading();

  @override
  List<Object> get props => [];
}

class RewardLoaded extends RewardState {
  final RewardPointsResponse rewardPointsResponse;

  const RewardLoaded(this.rewardPointsResponse);

  @override
  List<Object> get props => [rewardPointsResponse];
}

class RewardError extends RewardState {
  final String error;

  const RewardError(this.error);

  @override
  List<Object> get props => [error];
}

class RedeemLoaded extends RewardState {
  final RedeemResponse redeemResponse;
  final RewardPointsResponse rewardPointsResponse;

  const RedeemLoaded(this.redeemResponse, this.rewardPointsResponse);

  @override
  List<Object> get props => [redeemResponse, rewardPointsResponse];
}
