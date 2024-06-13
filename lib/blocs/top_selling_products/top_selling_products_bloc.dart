import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/models/products/product.dart';
import 'package:flutter_kundol/repos/products_repo.dart';

part 'top_selling_products_event.dart';

part 'top_selling_products_state.dart';

class TopSellingProductsBloc extends Bloc<TopSellingProductsEvent, TopSellingProductsState> {
  final ProductsRepo? productsRepo;

  TopSellingProductsBloc(this.productsRepo)
      : super(const TopSellingProductsState(
      status: TopSellingProductsStatus.initial,
      hasReachedMax: false,
      products: [],
      pageNo: 1));

  @override
  Stream<TopSellingProductsState> mapEventToState(TopSellingProductsEvent event) async* {
    if (event is GetTopSellingProducts) yield await _mapProductsFetchedToState(state);
  }

  Future<TopSellingProductsState> _mapProductsFetchedToState(TopSellingProductsState state) async {
    if (state.hasReachedMax!) return state;
    try {
      if (state.status == TopSellingProductsStatus.initial) {
        final products = await _fetchProducts(state.pageNo);
        return state.copyWith(
          status: TopSellingProductsStatus.success,
          products: products,
          hasReachedMax: false,
        );
      }
      final products = await _fetchProducts(state.pageNo + 1);
      return products.isEmpty
          ? state.copyWith(hasReachedMax: true, pageNo: state.pageNo + 1)
          : state.copyWith(
        status: TopSellingProductsStatus.success,
        products: List.of(state.products!)..addAll(products),
        hasReachedMax: false,
        pageNo: state.pageNo + 1,
      );
    } on Exception {
      return state.copyWith(status: TopSellingProductsStatus.failure);
    }
  }

  Future<List<Product>> _fetchProducts([int pageNumber = 1]) async {
    final response = await productsRepo!.fetchTopSellingProducts(pageNumber);
    if (response.status == AppConstants.STATUS_SUCCESS &&
        response.data != null) {
      return response.data!;
    } else {
      return [];
    }
  }
}


