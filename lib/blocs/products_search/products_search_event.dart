part of 'products_search_bloc.dart';

abstract class ProductsSearchEvent extends Equatable {
  const ProductsSearchEvent();
}

class GetSearchProducts extends ProductsSearchEvent {
  final String keyword;
  const GetSearchProducts(this.keyword);

  @override
  List<Object> get props => [keyword];
}

class SearchFiltersChanged extends ProductsSearchEvent {
  final String variation;
  final String attribute;
  final String variationName;
  final String pricFrom;
  final String priceTo;

  const SearchFiltersChanged(
      {this.variation = '',
      this.attribute = '',
      this.variationName = '',
      this.pricFrom = '',
      this.priceTo = ''});

  @override
  List<Object> get props =>
      [variation, attribute, variationName, pricFrom, priceTo];
}


class ClearSearchResults extends ProductsSearchEvent {
  const ClearSearchResults();

  @override
  List<Object> get props => [];
}
