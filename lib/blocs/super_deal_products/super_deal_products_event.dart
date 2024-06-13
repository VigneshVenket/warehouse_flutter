
part of 'super_deal_products_bloc.dart';

enum SuperDealProductsStatus { initial, success, failure }

class SuperDealProductsState extends Equatable {
  final List<Product>? products;
  final SuperDealProductsStatus? status;
  final bool? hasReachedMax;
  final pageNo;

  const SuperDealProductsState({this.products, this.status, this.hasReachedMax, this.pageNo});

  SuperDealProductsState copyWith(
      {SuperDealProductsStatus? status,
        List<Product>? products,
        bool? hasReachedMax,
        int? pageNo,}) {
    return SuperDealProductsState(products: products ?? this.products, status: status ?? this.status,hasReachedMax: hasReachedMax?? this.hasReachedMax, pageNo: pageNo?? this.pageNo);
  }

  @override
  List<Object> get props =>
      [products!, status!, hasReachedMax!, pageNo];
}
