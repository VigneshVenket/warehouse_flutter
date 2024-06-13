
part of 'related_products_bloc.dart';

class RelatedProductsState extends Equatable {
  final List<Product>? products;
  final ProductsStatus? status;
  final bool? hasReachedMax;
  final pageNo;

  const RelatedProductsState({this.products, this.status, this.hasReachedMax, this.pageNo});

  RelatedProductsState copyWith(
      {ProductsStatus? status,
        List<Product>? products,
        bool? hasReachedMax,
        int? pageNo,}) {
    return RelatedProductsState(products: products ?? this.products, status: status ?? this.status,hasReachedMax: hasReachedMax?? this.hasReachedMax, pageNo: pageNo?? this.pageNo);
  }

  @override
  List<Object> get props =>
      [products!, status!, hasReachedMax!, pageNo];
}
