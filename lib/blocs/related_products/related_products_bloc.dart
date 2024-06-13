import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/blocs/products/products_bloc.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/models/products/product.dart';
import 'package:flutter_kundol/repos/products_repo.dart';

part 'related_products_event.dart';

part 'related_products_state.dart';

class RelatedProductsBloc
    extends Bloc<RelatedProductsEvent, RelatedProductsState> {
  final ProductsRepo productsRepo;

  RelatedProductsBloc(this.productsRepo)
      : super(const RelatedProductsState(
            status: ProductsStatus.initial,
            hasReachedMax: false,
            products: [],
            pageNo: 1));

  @override
  Stream<RelatedProductsState> mapEventToState(
      RelatedProductsEvent event) async* {
    if (event is GetRelatedProducts)
      yield await _mapProductsFetchedToState(
          state, event.categoryId.toString());
  }

  Future<RelatedProductsState> _mapProductsFetchedToState(
      RelatedProductsState state, String categoryId) async {
    if (state.hasReachedMax!) return state;
    try {
      if (state.status == ProductsStatus.initial) {
        final products = await _fetchProducts(state.pageNo, categoryId);
        return state.copyWith(
          status: ProductsStatus.success,
          products: products,
          hasReachedMax: false,
        );
      }
      final products = await _fetchProducts(state.pageNo + 1, categoryId);
      return products.isEmpty
          ? state.copyWith(hasReachedMax: true, pageNo: state.pageNo + 1)
          : state.copyWith(
              status: ProductsStatus.success,
              products: List.of(state.products!)..addAll(products),
              hasReachedMax: false,
              pageNo: state.pageNo + 1,
            );
    } on Exception {
      return state.copyWith(status: ProductsStatus.failure);
    }
  }

  Future<List<Product>> _fetchProducts(
      [int pageNumber = 1, String? categoryId]) async {
    final response = await productsRepo.fetchProductsByCat(
      pageNumber,
      categoryId!,
      "id",
      "ASC",
    );
    if (response.status == AppConstants.STATUS_SUCCESS &&
        response.data != null) {
      return response.data!;
    } else {
      return [];
    }
  }
}
