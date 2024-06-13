
part of 'super_deal_products_bloc.dart';

abstract class SuperDealProductsEvent extends Equatable {
  const SuperDealProductsEvent();
}

class GetSuperDealProducts extends SuperDealProductsEvent {
  const GetSuperDealProducts();

  @override
  List<Object> get props => [];
}
