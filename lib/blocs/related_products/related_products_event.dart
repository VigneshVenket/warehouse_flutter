
part of 'related_products_bloc.dart';

abstract class RelatedProductsEvent extends Equatable {
  const RelatedProductsEvent();
}


class GetRelatedProducts extends RelatedProductsEvent {

  final String? categoryId;

  const GetRelatedProducts(this.categoryId);

  @override
  List<Object> get props => [categoryId!];
}