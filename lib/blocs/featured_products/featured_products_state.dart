
part of 'featured_products_bloc.dart';

enum FeaturedProductsStatus { initial, success, failure }

class FeaturedProductsState extends Equatable {
  final List<Product>? products;
  final FeaturedProductsStatus? status;
  final bool? hasReachedMax;
  final pageNo;

  const FeaturedProductsState({this.products, this.status, this.hasReachedMax, this.pageNo});

  FeaturedProductsState copyWith(
      {FeaturedProductsStatus? status,
        List<Product>? products,
        bool? hasReachedMax,
        int? pageNo,}) {
    return FeaturedProductsState(products: products ?? this.products, status: status ?? this.status,hasReachedMax: hasReachedMax?? this.hasReachedMax, pageNo: pageNo?? this.pageNo);
  }

  @override
  List<Object> get props =>
      [products!, status!, hasReachedMax!, pageNo];
}
