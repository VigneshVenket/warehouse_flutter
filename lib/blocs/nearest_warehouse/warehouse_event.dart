

import 'package:equatable/equatable.dart';

abstract class WarehouseEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchNearestWarehouseEvent extends WarehouseEvent {
  final String address;

  FetchNearestWarehouseEvent({required this.address});
}