
part of 'wishlist_detail_bloc.dart';

enum WishlistProductsStatus { initial, success, failure }

class WishlistProductsState extends Equatable {
  final List<WishlistDetailData>? wishlistData;
  final WishlistProductsStatus? status;
  final bool? hasReachedMax;
  final pageNo;

  const WishlistProductsState({this.wishlistData, this.status, this.hasReachedMax, this.pageNo});

  WishlistProductsState copyWith(
      {WishlistProductsStatus? status,
        List<WishlistDetailData>? wishlistData,
        bool? hasReachedMax,
        int? pageNo,}) {
    return WishlistProductsState(wishlistData: wishlistData ?? this.wishlistData, status: status ?? this.status,hasReachedMax: hasReachedMax?? this.hasReachedMax, pageNo: pageNo?? this.pageNo);
  }

  @override
  List<Object> get props =>
      [wishlistData!, status!, hasReachedMax!, pageNo];
}
