import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/models/products/product.dart';
import 'package:flutter_kundol/repos/products_repo.dart';

part 'products_event.dart';

part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductsRepo productsRepo;

  ProductsBloc(this.productsRepo)
      : super(const ProductsState(
            status: ProductsStatus.initial,
            hasReachedMax: false,
            products: [],
            pageNo: 1));

  @override
  Stream<ProductsState> mapEventToState(ProductsEvent event) async* {
    if (event is GetProducts) yield await _mapProductsFetchedToState(state);
  }

  Future<ProductsState> _mapProductsFetchedToState(ProductsState state) async {
    if (state.hasReachedMax!) return state;
    try {
      if (state.status == ProductsStatus.initial) {
        final products = await _fetchProducts(state.pageNo);
        return state.copyWith(
          status: ProductsStatus.success,
          products: products,
          hasReachedMax: false,
        );
      }
      final products = await _fetchProducts(state.pageNo + 1);
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

  Future<List<Product>> _fetchProducts([int pageNumber = 1]) async {
    final response = await productsRepo.fetchProducts(pageNumber);
    if (response.status == AppConstants.STATUS_SUCCESS &&
        response.data != null) {
      return response.data!;
    } else {
      return [];
    }
  }
}
