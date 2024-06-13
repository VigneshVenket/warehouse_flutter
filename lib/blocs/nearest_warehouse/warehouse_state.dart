
import 'package:equatable/equatable.dart';
import '../../models/nearest_warehouse.dart';

abstract class WarehouseState extends Equatable {
  @override
  List<Object?> get props => [];
}

class WarehouseInitialState extends WarehouseState {}

class WarehouseLoadedState extends WarehouseState {
  final Warehouse warehouse;

  WarehouseLoadedState({required this.warehouse});
}

class WarehouseErrorState extends WarehouseState {
  final String error;

  WarehouseErrorState({required this.error});
}