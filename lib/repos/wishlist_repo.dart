import 'package:flutter_kundol/api/api_provider.dart';
import 'package:flutter_kundol/api/responses/get_wishlist_on_start_response.dart';
import 'package:flutter_kundol/api/responses/wishlist_detail_response.dart';

abstract class WishlistRepo {
  Future<GetWishlistOnStartResponse> getWishListOnStart();
  Future<GetWishlistOnStartResponse> likeProduct(int productId);
  Future<GetWishlistOnStartResponse> unlikeProduct(int wishlistId);
  Future<WishlistDetailResponse> getWishlistProducts(int pageNo);
}

class RealWishlistRepo implements WishlistRepo {

  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<GetWishlistOnStartResponse> getWishListOnStart() {
    return _apiProvider.getWishlistOnStart();
  }

  @override
  Future<GetWishlistOnStartResponse> likeProduct(int productId) {
    return _apiProvider.likeProduct(productId);
  }

  @override
  Future<GetWishlistOnStartResponse> unlikeProduct(int wishlistId) {
    return _apiProvider.unLikeProduct(wishlistId);
  }

  @override
  Future<WishlistDetailResponse> getWishlistProducts(int pageNo) {
    return _apiProvider.getWishlistProducts(pageNo);
  }

}