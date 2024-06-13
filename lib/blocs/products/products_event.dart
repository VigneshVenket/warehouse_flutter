
part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();
}

class GetProducts extends ProductsEvent {
  const GetProducts();

  @override
  List<Object> get props => [];
}
