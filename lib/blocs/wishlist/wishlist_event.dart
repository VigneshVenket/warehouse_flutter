part of 'wishlist_bloc.dart';

abstract class WishlistEvent extends Equatable {
  const WishlistEvent();
}

class GetWishlistOnStart extends WishlistEvent {
  const GetWishlistOnStart();

  @override
  List<Object> get props => [];
}

class LikeProduct extends WishlistEvent {
  final int? productId;

  const LikeProduct(this.productId);

  @override
  List<Object> get props => [productId!];
}

class UnLikeProduct extends WishlistEvent {
  final int? wishlistId;

  const UnLikeProduct(this.wishlistId);

  @override
  List<Object> get props => [wishlistId!];
}
