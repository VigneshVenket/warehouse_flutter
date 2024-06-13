part of 'products_by_cat_bloc.dart';

abstract class ProductsByCatEvent extends Equatable {
  const ProductsByCatEvent();
}

class GetProductsByCat extends ProductsByCatEvent {
  final int? categoryId;
  final String? sortBy;
  const GetProductsByCat(this.categoryId, this.sortBy);

  @override
  List<Object> get props => [categoryId!, sortBy!];
}

class CategoryChanged extends ProductsByCatEvent {
  final int categoryId;
  const CategoryChanged(this.categoryId);

  @override
  List<Object> get props => [categoryId];
}

class SortByChanged extends ProductsByCatEvent {
  final String? sortBy;
  const SortByChanged(this.sortBy);

  @override
  List<Object> get props => [sortBy!];
}

class SortTypeChanged extends ProductsByCatEvent {
  final String sortType;
  const SortTypeChanged(this.sortType);

  @override
  List<Object> get props => [sortType];
}

class FiltersChanged extends ProductsByCatEvent {
  final String variation;
  final String attribute;
  final String variationName;
  final String pricFrom;
  final String priceTo;

  const FiltersChanged(
      {this.variation = '',
      this.attribute = '',
      this.variationName = '',
      this.pricFrom = '',
      this.priceTo = ''});

  @override
  List<Object> get props => [variation, attribute, variationName, pricFrom, priceTo];
}
