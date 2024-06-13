part of 'featured_products_bloc.dart';

abstract class FeaturedProductsEvent extends Equatable {
  const FeaturedProductsEvent();
}

class GetFeaturedProducts extends FeaturedProductsEvent {
  const GetFeaturedProducts();

  @override
  List<Object> get props => [];
}

class FeaturedFiltersChanged extends FeaturedProductsEvent {
  final String variation;
  final String attribute;
  final String variationName;
  final String pricFrom;
  final String priceTo;

  const FeaturedFiltersChanged(
      {this.variation = '',
      this.attribute = '',
      this.variationName = '',
      this.pricFrom = '',
      this.priceTo = ''});

  @override
  List<Object> get props =>
      [variation, attribute, variationName, pricFrom, priceTo];
}
