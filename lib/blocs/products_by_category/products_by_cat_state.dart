
part of 'products_by_cat_bloc.dart';

class ProductsByCatState extends Equatable {
  final List<Product>? products;
  final ProductsStatus? status;
  final bool? hasReachedMax;
  final pageNo;

  const ProductsByCatState({this.products, this.status, this.hasReachedMax, this.pageNo});

  ProductsByCatState copyWith(
      {ProductsStatus? status,
        List<Product>? products,
        bool? hasReachedMax,
        int? pageNo,}) {
    return ProductsByCatState(products: products ?? this.products, status: status ?? this.status,hasReachedMax: hasReachedMax?? this.hasReachedMax, pageNo: pageNo?? this.pageNo);
  }

  @override
  List<Object> get props =>
      [products!, status!, hasReachedMax!, pageNo];
}
