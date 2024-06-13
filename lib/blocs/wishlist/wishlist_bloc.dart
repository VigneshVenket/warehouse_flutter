import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/api/responses/get_wishlist_on_start_response.dart';
import 'package:flutter_kundol/blocs/wishlist_detail/wishlist_detail_bloc.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/repos/wishlist_repo.dart';

part 'wishlist_event.dart';

part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final WishlistRepo? wishlistRepo;
  final WishlistProductsBloc? wishlistProductsBloc;

  WishlistBloc(this.wishlistRepo, this.wishlistProductsBloc) : super(WishlistInitial());

  @override
  Stream<WishlistState> mapEventToState(WishlistEvent event) async* {
    if (event is GetWishlistOnStart){
      try {
        final wishlistOnStartResponse = await wishlistRepo!.getWishListOnStart();
        if (wishlistOnStartResponse.status == AppConstants.STATUS_SUCCESS &&
            wishlistOnStartResponse.data != null) {
          yield WishlistLoaded(wishlistOnStartResponse);
        } else {
          yield WishlistError(wishlistOnStartResponse.message!);
        }
      } on Error {
        yield const WishlistError("Couldn't fetch weather. Is the device online?");
      }
    } else if (event is LikeProduct) {
      try {
        final likeProductResponse = await wishlistRepo!.likeProduct(event.productId!);
        if (likeProductResponse.status == AppConstants.STATUS_SUCCESS &&
            likeProductResponse.data != null) {
          yield WishlistLoaded(likeProductResponse);
        } else {
          yield WishlistError(likeProductResponse.message!);
        }
      } on Error {
        yield const WishlistError("Couldn't fetch weather. Is the device online?");
      }
    } else if(event is UnLikeProduct) {
      try {
        final unlikeProductResonse = await wishlistRepo!.unlikeProduct(event.wishlistId!);
        if (unlikeProductResonse.status == AppConstants.STATUS_SUCCESS &&
            unlikeProductResonse.data != null) {
          wishlistProductsBloc?.add(RefreshWishlistProducts());
          yield WishlistLoaded(unlikeProductResonse);
        }
        else {
          yield WishlistError(unlikeProductResonse.message!);
        }
      } on Error {
        yield const WishlistError("Couldn't fetch weather. Is the device online?");
      }
    }
  }

}