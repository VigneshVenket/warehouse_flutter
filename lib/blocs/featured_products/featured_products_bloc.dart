import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/models/products/product.dart';
import 'package:flutter_kundol/repos/products_repo.dart';

part 'featured_products_event.dart';

part 'featured_products_state.dart';

class FeaturedProductsBloc
    extends Bloc<FeaturedProductsEvent, FeaturedProductsState> {
  final ProductsRepo productsRepo;

  FeaturedProductsBloc(this.productsRepo)
      : super(const FeaturedProductsState(
            status: FeaturedProductsStatus.initial,
            hasReachedMax: false,
            products: [],
            pageNo: 1));

  @override
  Stream<FeaturedProductsState> mapEventToState(
      FeaturedProductsEvent event) async* {
    if (event is GetFeaturedProducts) {
      yield await _mapProductsFetchedToState(state);
    } else if (event is FeaturedFiltersChanged) {
      yield await _mapFiltersChangedToState(event, state);
    }
  }

  Future<FeaturedProductsState> _mapProductsFetchedToState(
      FeaturedProductsState state) async {
    if (state.hasReachedMax!) return state;
    try {
      if (state.status == FeaturedProductsStatus.initial) {
        final products = await _fetchProducts(state.pageNo);
        return state.copyWith(
          status: FeaturedProductsStatus.success,
          products: products,
          hasReachedMax: false,
        );
      }
      final products = await _fetchProducts(state.pageNo + 1);
      return products.isEmpty
          ? state.copyWith(hasReachedMax: true, pageNo: state.pageNo + 1)
          : state.copyWith(
              status: FeaturedProductsStatus.success,
              products: List.of(state.products!)..addAll(products),
              hasReachedMax: false,
              pageNo: state.pageNo + 1,
            );
    } on Exception {
      return state.copyWith(status: FeaturedProductsStatus.failure);
    }
  }

  String? variation;
  String? variationName;
  String? attribute;
  String? pricFrom;
  String? priceTo;

  Future<FeaturedProductsState> _mapFiltersChangedToState(
      FeaturedFiltersChanged event, FeaturedProductsState state) async {
    variation = event.variation;
    variationName = event.variationName;
    attribute = event.attribute;
    pricFrom = event.pricFrom;
    priceTo = event.priceTo;
    debugPrint("filters variation string : ${event}");
    try {
      List.of(state.products!).clear();
      final products = await _fetchProducts();
      debugPrint("filtered response item legnth  : ${products.length}");
      return state.copyWith(
        status: FeaturedProductsStatus.success,
        products: products,
        hasReachedMax: false,
        pageNo: 1,
      );
    } on Exception {
      return state.copyWith(status: FeaturedProductsStatus.failure);
    }
  }

  Future<List<Product>> _fetchProducts([int pageNumber = 1]) async {
    final response = await productsRepo.fetchFeaturedProducts(pageNumber,
        variation: variation,
        attributes: attribute,
        variation_name: variationName,
        priceFrom: pricFrom,
        priceTo: priceTo);
    if (response.status == AppConstants.STATUS_SUCCESS &&
        response.data != null) {
      return response.data!;
    } else {
      return [];
    }
  }
}
