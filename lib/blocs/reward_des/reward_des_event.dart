import 'package:equatable/equatable.dart';

abstract class RewarddesEvent extends Equatable {
  RewarddesEvent();
}

class GetRewarddes extends RewarddesEvent {

  GetRewarddes();

  @override
  List<Object> get props => [];

  @override
  RewarddesEvent() {
    // TODO: implement WalleEvent
    throw UnimplementedError();
  }
}