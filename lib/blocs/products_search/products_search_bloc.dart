import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/models/products/product.dart';
import 'package:flutter_kundol/repos/products_repo.dart';

part 'products_search_event.dart';

part 'products_search_state.dart';

class ProductsSearchBloc
    extends Bloc<ProductsSearchEvent, ProductsSearchState> {
  final ProductsRepo productsRepo;

  ProductsSearchBloc(this.productsRepo)
      : super(const ProductsSearchState(
            status: ProductsSearchStatus.initial,
            hasReachedMax: false,
            products: [],
            pageNo: 1));

  @override
  Stream<ProductsSearchState> mapEventToState(
      ProductsSearchEvent event) async* {
    if (event is GetSearchProducts) {
      yield const ProductsSearchState(
          status: ProductsSearchStatus.loading,
          hasReachedMax: false,
          products: [],
          pageNo: 1);
      yield await _mapProductsFetchedToState(event, state);
    } else if (event is SearchFiltersChanged) {
      yield await _mapFiltersChangedToState(event, state);
    } else if (event is ClearSearchResults) {
      yield const ProductsSearchState(
          status: ProductsSearchStatus.initial,
          hasReachedMax: false,
          products: [],
          pageNo: 1);
    }
  }

  Future<ProductsSearchState> _mapProductsFetchedToState(
      GetSearchProducts event, ProductsSearchState state) async {
    if (state.hasReachedMax!) return state;
    try {
      if (state.status == ProductsSearchStatus.initial) {
        final products = await _fetchProducts(event.keyword, state.pageNo);
        return state.copyWith(
          status: ProductsSearchStatus.success,
          products: products,
          hasReachedMax: false,
        );
      }
      final products = await _fetchProducts(event.keyword, state.pageNo);
      return state.copyWith(
        status: ProductsSearchStatus.success,
        products: products,
        hasReachedMax: false,
        pageNo: state.pageNo,
      );
    } on Exception {
      return state.copyWith(status: ProductsSearchStatus.failure);
    }
  }

  String? variation;
  String? variationName;
  String? attribute;
  String? pricFrom;
  String? priceTo;

  Future<ProductsSearchState> _mapFiltersChangedToState(
      SearchFiltersChanged event, ProductsSearchState state) async {
    try {
      variation = event.variation;
      variationName = event.variationName;
      attribute = event.attribute;
      pricFrom = event.pricFrom;
      priceTo = event.priceTo;
      final products = await _fetchProducts('', 1);
      return state.copyWith(
          status: ProductsSearchStatus.success,
          products: products,
          hasReachedMax: false,
          pageNo: 1);
    } on Exception {
      return state.copyWith(status: ProductsSearchStatus.failure);
    }
  }

  Future<List<Product>> _fetchProducts(
      [String? keyword, int pageNumber = 1]) async {
    final response = await productsRepo.fetchSearchProducts(
        keyword!, pageNumber,
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
