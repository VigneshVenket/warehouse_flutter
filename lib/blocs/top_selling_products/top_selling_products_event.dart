
part of 'top_selling_products_bloc.dart';

abstract class TopSellingProductsEvent extends Equatable {
  const TopSellingProductsEvent();
}

class GetTopSellingProducts extends TopSellingProductsEvent {
  const GetTopSellingProducts();

  @override
  List<Object> get props => [];
}
