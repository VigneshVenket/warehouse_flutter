
part of 'new_arrival_product_bloc.dart';

abstract class NewArrivalProductsEvent extends Equatable {
  const NewArrivalProductsEvent();
}

class GetNewArrivalProducts extends NewArrivalProductsEvent {
  final int? categoryId;

  const GetNewArrivalProducts(this.categoryId);

  @override
  List<Object> get props => [categoryId!,];
}

class CategoryChanged extends NewArrivalProductsEvent {
  final int categoryId;
  const CategoryChanged(this.categoryId);

  @override
  List<Object> get props => [categoryId];
}