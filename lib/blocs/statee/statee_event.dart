import 'package:equatable/equatable.dart';

abstract class StateeEvent extends Equatable {
  StateeEvent();
}

class GetStatee extends StateeEvent {
  final int? value;
  GetStatee(this.value);
  @override
  List<Object> get props => [value!];

  @override
  StateeEvent() {
    // TODO: implement WalleEvent
    throw UnimplementedError();
  }
}