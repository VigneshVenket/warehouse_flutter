
part of 'wishlist_detail_bloc.dart';

abstract class WishlistDetailEvent extends Equatable {
   WishlistDetailEvent();
}

class GetWishlistProducts extends WishlistDetailEvent {

  GetWishlistProducts();

  @override
  List<Object> get props => [];
}

class RefreshWishlistProducts extends WishlistDetailEvent {

  RefreshWishlistProducts();

  @override
  List<Object> get props => [];
}
