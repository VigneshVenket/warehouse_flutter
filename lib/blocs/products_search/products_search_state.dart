part of 'products_search_bloc.dart';

enum ProductsSearchStatus { initial, success, failure, loading }

class ProductsSearchState extends Equatable {
  final List<Product>? products;
  final ProductsSearchStatus? status;
  final bool? hasReachedMax;
  final pageNo;

  const ProductsSearchState({this.products, this.status, this.hasReachedMax, this.pageNo});

  ProductsSearchState copyWith(
      {ProductsSearchStatus? status,
        List<Product>? products,
        bool? hasReachedMax,
        int? pageNo,}) {
    return ProductsSearchState(products: products ?? this.products, status: status ?? this.status,hasReachedMax: hasReachedMax?? this.hasReachedMax, pageNo: pageNo?? this.pageNo);
  }

  @override
  List<Object> get props =>
      [products!, status!, hasReachedMax!, pageNo];
}
