import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../constants/app_constants.dart';
import '../../repos/products_repo.dart';
import 'package:flutter_kundol/models/products/product.dart';

import '../categories/categories_bloc.dart';

part 'new_arrival_product_state.dart';

part 'new_arrival_product_event.dart';

class NewArrivalProductBloc
    extends Bloc<NewArrivalProductsEvent, NewArrivalProductsState> {
  final ProductsRepo productsRepo;
  int? categoryId;
  final CategoriesBloc? categoriesBloc;
  StreamSubscription? categoriesSubscription;

  NewArrivalProductBloc(this.productsRepo, this.categoryId, this.categoriesBloc)
      : super(const NewArrivalProductsState(
            status: NewArrivalProductsStatus.initial,
            hasReachedMax: false,
            products: [],
            pageNo: 1)) {
    categoriesSubscription = categoriesBloc?.stream.listen((state) {
      if (state is CategoriesLoaded) {
        add(GetNewArrivalProducts(categoryId!));
      }
    });
  }

  @override
  Stream<NewArrivalProductsState> mapEventToState(
      NewArrivalProductsEvent event) async* {
    if (event is GetNewArrivalProducts) {
      yield await _mapProductsFetchedToState(state);
    } else if (event is CategoryChanged) {
      yield await _mapCategoryChangedToState(event, state);
    }
  }

  Future<NewArrivalProductsState> _mapProductsFetchedToState(
      NewArrivalProductsState state) async {
    if (state.hasReachedMax!) return state;
    try {
      if (state.status == NewArrivalProductsStatus.initial) {
        final products = await _fetchProducts(state.pageNo);
        return state.copyWith(
          status: NewArrivalProductsStatus.success,
          products: products,
          hasReachedMax: false,
        );
      }
      final products = await _fetchProducts(state.pageNo + 1);
      return products.isEmpty
          ? state.copyWith(hasReachedMax: true, pageNo: state.pageNo + 1)
          : state.copyWith(
              status: NewArrivalProductsStatus.success,
              products: List.of(state.products!)..addAll(products),
              hasReachedMax: false,
              pageNo: state.pageNo + 1,
            );
    } on Exception {
      return state.copyWith(status: NewArrivalProductsStatus.failure);
    }
  }

  Future<NewArrivalProductsState> _mapCategoryChangedToState(
      CategoryChanged event, NewArrivalProductsState state) async {
    try {
      categoryId = event.categoryId;
      final products = await _fetchProducts(1);
      return state.copyWith(
          status: NewArrivalProductsStatus.success,
          products: products,
          hasReachedMax: false,
          pageNo: 1);
    } on Exception {
      return state.copyWith(status: NewArrivalProductsStatus.failure);
    }
  }

  Future<List<Product>> _fetchProducts([int pageNumber = 1]) async {
    final response = await productsRepo.fetchNewArrivalProduct(
        pageNumber, categoryId.toString());
    debugPrint("new arrival api response ${response.statusCode}, ${response.message}");
    if (response.status == AppConstants.STATUS_SUCCESS &&
        response.data != null) {
      return response.data!;
    } else {
      return [];
    }
  }
}
