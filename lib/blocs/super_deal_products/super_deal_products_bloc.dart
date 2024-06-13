import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/models/products/product.dart';
import 'package:flutter_kundol/repos/products_repo.dart';

part 'super_deal_products_event.dart';

part 'super_deal_products_state.dart';

class SuperDealProductsBloc
    extends Bloc<SuperDealProductsEvent, SuperDealProductsState> {
  final ProductsRepo productsRepo;

  SuperDealProductsBloc(this.productsRepo)
      : super(const SuperDealProductsState(
            status: SuperDealProductsStatus.initial,
            hasReachedMax: false,
            products: [],
            pageNo: 1));

  @override
  Stream<SuperDealProductsState> mapEventToState(SuperDealProductsEvent event) async* {
    if (event is GetSuperDealProducts) yield await _mapProductsFetchedToState(state);
  }

  Future<SuperDealProductsState> _mapProductsFetchedToState(SuperDealProductsState state) async {
    if (state.hasReachedMax!) return state;
    try {
      if (state.status == SuperDealProductsStatus.initial) {
        final products = await _fetchProducts(state.pageNo);
        return state.copyWith(
          status: SuperDealProductsStatus.success,
          products: products,
          hasReachedMax: false,
        );
      }
      final products = await _fetchProducts(state.pageNo + 1);
      return products.isEmpty
          ? state.copyWith(hasReachedMax: true, pageNo: state.pageNo + 1)
          : state.copyWith(
        status: SuperDealProductsStatus.success,
        products: List.of(state.products!)..addAll(products),
        hasReachedMax: false,
        pageNo: state.pageNo + 1,
      );
    } on Exception {
      return state.copyWith(status: SuperDealProductsStatus.failure);
    }
  }

  Future<List<Product>> _fetchProducts([int pageNumber = 1]) async {
    final response = await productsRepo.fetchSuperDealsProducts(pageNumber);
    if (response.status == AppConstants.STATUS_SUCCESS &&
        response.data != null) {
      return response.data!;
    } else {
      return [];
    }
  }

}
