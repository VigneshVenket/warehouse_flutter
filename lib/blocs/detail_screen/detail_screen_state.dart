part of 'detail_screen_bloc.dart';

abstract class DetailPageState extends Equatable {
  const DetailPageState();
}

class DetailPageInitial extends DetailPageState {
  const DetailPageInitial();

  @override
  List<Object> get props => [];
}

class GetQuantityLoaded extends DetailPageState {
  final QuantityData quantityData;

  const GetQuantityLoaded(this.quantityData);

  @override
  List<Object> get props => [this.quantityData];
}

class DetailPageError extends DetailPageState {
  final String? error;

  const DetailPageError(this.error);

  @override
  List<Object> get props => [this.error!];
}

class ItemCartAdded extends DetailPageState {
  final String? message;
  final String ?sessionId;

  const ItemCartAdded(this.message, this.sessionId);

  @override
  List<Object> get props => [this.message!, this.sessionId!];
}

class ProductDetailsLoaded extends DetailPageState {

  final Product? product;

  const ProductDetailsLoaded(this.product);

  @override
  List<Object> get props => [this.product!];
}
