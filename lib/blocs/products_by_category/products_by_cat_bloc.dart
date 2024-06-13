import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/blocs/categories/categories_bloc.dart';
import 'package:flutter_kundol/blocs/products/products_bloc.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/models/products/product.dart';
import 'package:flutter_kundol/repos/products_repo.dart';

part 'products_by_cat_event.dart';

part 'products_by_cat_state.dart';

class ProductsByCatBloc extends Bloc<ProductsByCatEvent, ProductsByCatState> {
  final CategoriesBloc? categoriesBloc;
  final ProductsRepo? productsRepo;
  int? categoryId;
  String? sortBy;
  String? sortType;
  String? filters;
  StreamSubscription? categoriesSubscription;

  ProductsByCatBloc(this.productsRepo, this.categoriesBloc, this.categoryId,
      this.sortBy, this.sortType, this.filters)
      : super(const ProductsByCatState(
            status: ProductsStatus.initial,
            hasReachedMax: false,
            products: [],
            pageNo: 1)) {
    categoriesSubscription = categoriesBloc?.stream.listen((state) {
      if (state is CategoriesLoaded) {
        add(GetProductsByCat(categoryId!, sortBy!));
      }
    });
  }

  @override
  Stream<ProductsByCatState> mapEventToState(ProductsByCatEvent event) async* {
    if (event is GetProductsByCat) {
      yield await _mapProductsFetchedToState(state);
    } else if (event is CategoryChanged) {
      yield await _mapCategoryChangedToState(event, state);
    } else if (event is SortByChanged) {
      yield await _mapSortByChangedToState(event, state);
    } else if (event is SortTypeChanged) {
      yield await _mapSortTypeChangedToState(event, state);
    } else if (event is FiltersChanged) {
      yield await _mapFiltersChangedToState(event, state);
    }
  }

  Future<ProductsByCatState> _mapProductsFetchedToState(
      ProductsByCatState state) async {
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

  Future<ProductsByCatState> _mapCategoryChangedToState(
      CategoryChanged event, ProductsByCatState state) async {
    try {
      categoryId = event.categoryId;
      final products = await _fetchProducts(1);
      return state.copyWith(
          status: ProductsStatus.success,
          products: products,
          hasReachedMax: false,
          pageNo: 1);
    } on Exception {
      return state.copyWith(status: ProductsStatus.failure);
    }
  }

  Future<ProductsByCatState> _mapSortByChangedToState(
      SortByChanged event, ProductsByCatState state) async {
    try {
      sortBy = event.sortBy;
      final products = await _fetchProducts(1);
      return state.copyWith(
          status: ProductsStatus.success,
          products: products,
          hasReachedMax: false,
          pageNo: 1);
    } on Exception {
      return state.copyWith(status: ProductsStatus.failure);
    }
  }

  Future<ProductsByCatState> _mapSortTypeChangedToState(
      SortTypeChanged event, ProductsByCatState state) async {
    try {
      sortType = event.sortType;
      final products = await _fetchProducts(1);
      return state.copyWith(
          status: ProductsStatus.success,
          products: products,
          hasReachedMax: false,
          pageNo: 1);
    } on Exception {
      return state.copyWith(status: ProductsStatus.failure);
    }
  }

  String? variation;
  String? variationName;
  String? attribute;
  String? pricFrom;
  String? priceTo;

  Future<ProductsByCatState> _mapFiltersChangedToState(
      FiltersChanged event, ProductsByCatState state) async {
    try {
      variation = event.variation;
      variationName = event.variationName;
      attribute = event.attribute;
      pricFrom = event.pricFrom;
      priceTo = event.priceTo;
      final products = await _fetchProducts(1);
      return state.copyWith(
          status: ProductsStatus.success,
          products: products,
          hasReachedMax: false,
          pageNo: 1);
    } on Exception {
      return state.copyWith(status: ProductsStatus.failure);
    }
  }

  Future<List<Product>> _fetchProducts([int pageNumber = 1]) async {
    final response = await productsRepo!.fetchProductsByCat(
        pageNumber, categoryId.toString(), sortBy!, sortType!,
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
