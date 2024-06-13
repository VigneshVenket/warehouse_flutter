
part of 'detail_screen_bloc.dart';

abstract class DetailPageEvent extends Equatable {
  const DetailPageEvent();
}

class GetQuantity extends DetailPageEvent {

  var productId;
  final String? productType;
  var combinationId;

   GetQuantity(this.productId, this.productType, this.combinationId);

  @override
  List<Object> get props => [this.productId!, this.productType!, this.combinationId!];
}

class AddToCart extends DetailPageEvent {

  final int? productId;
  final int? qty;
  final int? combinationId;

  const AddToCart(this.productId, this.qty, this.combinationId);

  @override
  List<Object> get props => [this.productId!, this.qty!, this.combinationId!];
}

class GetProductById extends DetailPageEvent {

  var productId;

   GetProductById(this.productId);

  @override
  List<Object> get props => [productId!];
}