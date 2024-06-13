import 'package:equatable/equatable.dart';

abstract class RewardnEvent extends Equatable {
  RewardnEvent();
}

class GetRewardn extends RewardnEvent {

  GetRewardn();

  @override
  List<Object> get props => [];

  @override
  RewardnEvent() {
    // TODO: implement WalleEvent
    throw UnimplementedError();
  }
}