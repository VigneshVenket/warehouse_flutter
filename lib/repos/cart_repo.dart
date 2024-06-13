import 'package:flutter_kundol/api/api_provider.dart';
import 'package:flutter_kundol/api/responses/cart_response.dart';
import 'package:flutter_kundol/api/responses/delete_cart_response.dart';
import 'package:flutter_kundol/api/responses/quantity_response.dart';
import 'package:flutter_kundol/models/add_to_cart/add_to_cart.dart';
import 'package:flutter_kundol/models/coupon_response.dart';

import '../api/responses/update_cart_response.dart';

abstract class CartRepo {
  Future<QuantityResponse> checkQuantity(int productId, String productType, int combinationId);
  Future<CartResponse> getCart();
  Future<DeleteCartResponse> deleteCartItem(int? productId, int? combinationId);
  Future<AddToCartResponse> addToCart(int productId, int qty, int? combinationId);
  Future<CouponResponse> applyCoupon(String coupon);
  Future<UpdateCartResponse> updateCart(int? productId, var combinationId,int qty);
}

class RealCartRepo implements CartRepo {
  ApiProvider _apiProvider = ApiProvider();

  @override
  Future<QuantityResponse> checkQuantity(int productId, String productType, int combinationId) {
    _apiProvider = ApiProvider();
    return _apiProvider.getQuantity(productId, productType, combinationId);
  }

  @override
  Future<CartResponse> getCart() {
    _apiProvider = ApiProvider();
    return _apiProvider.getCart();
  }

  @override
  Future<DeleteCartResponse> deleteCartItem(int? productId, int? combinationId) {
    _apiProvider = ApiProvider();
    return _apiProvider.deleteCartItem(productId, combinationId);
  }

  @override
  Future<AddToCartResponse> addToCart(int productId, int qty, int? combinationId) {
    return _apiProvider.addToCart(productId, qty, combinationId);
  }

  @override
  Future<CouponResponse> applyCoupon(String coupon) {
    return _apiProvider.applyCoupon(coupon);
  }

  @override
  Future<UpdateCartResponse> updateCart(int? productId, var combinationId,int qty) {
    _apiProvider = ApiProvider();
    return _apiProvider.updateCart(productId, combinationId, qty);
  }
}

class FakeCartRepo implements CartRepo {
  @override
  Future<QuantityResponse> checkQuantity(int productId, String productType, int combinationId) {
    throw UnimplementedError();
  }

  @override
  Future<CartResponse> getCart() {
    throw UnimplementedError();
  }

  @override
  Future<DeleteCartResponse> deleteCartItem(int? productId, int? combinationId) {
    throw UnimplementedError();
  }

  @override
  Future<AddToCartResponse> addToCart(int productId, int qty, int? combinationId) {
    throw UnimplementedError();
  }

  @override
  Future<CouponResponse> applyCoupon(String coupon) {
    throw UnimplementedError();
  }

  @override
  Future<UpdateCartResponse> updateCart(int? productId, var combinationId,int qty) {
    throw UnimplementedError();
  }
}
