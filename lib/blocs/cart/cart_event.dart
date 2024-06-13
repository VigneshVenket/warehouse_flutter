
part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
}

class GetCart extends CartEvent {

  const GetCart();

  @override
  List<Object> get props => [];

}

class DeleteCartItem extends CartEvent {

  final int? productId;
  final int? combinationId;

  const DeleteCartItem(this.productId, this.combinationId);

  @override
  List<Object> get props => [productId!, combinationId!];

}

class UpdateCart extends CartEvent{

  final int? productId;
  var combinationId;
  final int qty;

  UpdateCart(this.productId,this.combinationId,this.qty);

  @override
  List<Object> get props => [productId!, combinationId!,qty!];
}


class UpdateFromCart extends CartEvent{

  final int? productId;
  final int? combinationId;
  final int qty;

  const UpdateFromCart(this.productId,this.combinationId,this.qty);

  @override
  List<Object> get props => [productId!, combinationId!,qty!];
}

class ApplyCoupon extends CartEvent {

  final String? coupon;

  const ApplyCoupon(this.coupon);

  @override
  List<Object> get props => [coupon!];

}