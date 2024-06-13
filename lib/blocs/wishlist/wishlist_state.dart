
part of 'wishlist_bloc.dart';

abstract class WishlistState extends Equatable {
  const WishlistState();
}

class WishlistInitial extends WishlistState {
  const WishlistInitial();

  @override
  List<Object> get props => [];
}

class WishlistLoading extends WishlistState {
  const WishlistLoading();

  @override
  List<Object> get props => [];
}

class WishlistLoaded extends WishlistState {
  final GetWishlistOnStartResponse wishlistResponse;

  const WishlistLoaded(this.wishlistResponse);

  @override
  List<Object> get props => [wishlistResponse];
}

class WishlistError extends WishlistState {
  final String error;

  const WishlistError(this.error);

  @override
  List<Object> get props => [error];
}
