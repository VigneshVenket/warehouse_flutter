
part of 'new_arrival_product_bloc.dart';

enum NewArrivalProductsStatus { initial, success, failure }

class NewArrivalProductsState extends Equatable {
  final List<Product>? products;
  final NewArrivalProductsStatus? status;
  final bool? hasReachedMax;
  final pageNo;

  const NewArrivalProductsState({this.products, this.status, this.hasReachedMax, this.pageNo});

  NewArrivalProductsState copyWith(
      {NewArrivalProductsStatus? status,
        List<Product>? products,
        bool? hasReachedMax,
        int? pageNo,}) {
    return NewArrivalProductsState(products: products ?? this.products, status: status ?? this.status,hasReachedMax: hasReachedMax?? this.hasReachedMax, pageNo: pageNo?? this.pageNo);
  }

  @override
  List<Object> get props =>
      [products!, status!, hasReachedMax!, pageNo];
}