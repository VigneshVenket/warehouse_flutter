
part of 'reward_bloc.dart';

abstract class RewardEvent extends Equatable {
  const RewardEvent();
}

class GetRewardPoints extends RewardEvent {
  const GetRewardPoints();

  @override
  List<Object> get props => [];
}

class RedeemPoints extends RewardEvent {

  const RedeemPoints();

  @override
  List<Object> get props => [];

}