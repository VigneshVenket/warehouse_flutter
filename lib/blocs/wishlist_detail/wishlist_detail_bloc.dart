import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/models/wishlistDetailData.dart';
import 'package:flutter_kundol/repos/wishlist_repo.dart';

part 'wishlist_detail_event.dart';

part 'wishlist_detail_state.dart';

class WishlistProductsBloc extends Bloc<WishlistDetailEvent, WishlistProductsState> {
  final WishlistRepo? wishlistRepo;

  WishlistProductsBloc(this.wishlistRepo) : super( WishlistProductsState(status: WishlistProductsStatus.initial, hasReachedMax: false, wishlistData: [], pageNo: 1));

  @override
  Stream<WishlistProductsState> mapEventToState(WishlistDetailEvent event) async* {
    if (event is GetWishlistProducts) {
      yield await _mapProductsFetchedToState(state);
    } else if (event is RefreshWishlistProducts) {
      yield await _mapProductsRefreshToState(state);
    }
  }

  Future<WishlistProductsState> _mapProductsFetchedToState(WishlistProductsState state) async {
    if (state.hasReachedMax!) return state;
    try {
      if (state.status == WishlistProductsStatus.initial) {
        final wishlistData = await _fetchProducts(state.pageNo);
        return state.copyWith(
          status: WishlistProductsStatus.success,
          wishlistData: wishlistData,
          hasReachedMax: false,
        );
      }
      final products = await _fetchProducts(state.pageNo+1);
      return products.isEmpty
          ? state.copyWith(hasReachedMax: true, pageNo: state.pageNo+1)
          : state.copyWith(
        status: WishlistProductsStatus.success,
        wishlistData: state.wishlistData,
        //wishlistData: List.of(state.products)..addAll(products),
        hasReachedMax: false,
        pageNo: state.pageNo+1,
      );
    } on Exception {
      return state.copyWith(status: WishlistProductsStatus.failure);
    }
  }

  Future<WishlistProductsState> _mapProductsRefreshToState(WishlistProductsState state) async {
    if (state.hasReachedMax!) return state;
    try {
      final wishlistData = await _fetchProducts(1);
      return state.copyWith(
          status: WishlistProductsStatus.success,
          wishlistData: wishlistData,
          hasReachedMax: false,
          pageNo: 1
      );
    } on Exception {
      return state.copyWith(status: WishlistProductsStatus.failure);
    }
  }

  Future<List<WishlistDetailData>> _fetchProducts([int pageNumber = 1]) async {
    final response = await wishlistRepo!.getWishlistProducts(pageNumber);
    if (response.status == AppConstants.STATUS_SUCCESS &&
        response.data != null) {
      return response.data!;
    } else {
      return [];
    }
  }
}
