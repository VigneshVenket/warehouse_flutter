import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/models/cart_data.dart';
import 'package:flutter_kundol/models/coupon_data.dart';
import 'package:flutter_kundol/repos/cart_repo.dart';

import '../../api/responses/update_cart_response.dart';

part 'cart_state.dart';

part 'cart_event.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartRepo? cartRepo;

  CartBloc(this.cartRepo) : super(const CartInitial());

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    if (event is GetCart) {
      try {
        final cartResponse = await cartRepo?.getCart();
        if (cartResponse?.status == AppConstants.STATUS_SUCCESS &&
            cartResponse?.data != null) {
          yield CartLoaded(cartResponse!.data!);
        } else {
          print("Error Occured");
          yield CartError(cartResponse!.message!);
        }
      } on Error {
        yield const CartError("Couldn't fetch weather. Is the device online?");
      }
    } else if (event is DeleteCartItem) {
      try {
        final deleteCartResponse = await cartRepo?.deleteCartItem(event.productId!, event.combinationId);
        if(deleteCartResponse?.status == AppConstants.STATUS_SUCCESS) {
          yield CartDeleted(event.productId!);
        } else {
          yield CartError(deleteCartResponse!.message!);
        }
      }
      catch(e,stacktrace) {
        print('error caught: $e');
        print("stacktrace:" + stacktrace.toString());
        yield CartError("Some Error Occurred");
      }
      // on Error {
      //   yield const CartError("Couldn't fetch weather. okkkkkk Is the device online?");
      // }
    } else if (event is UpdateCart) {
      try {
        final updateCartResponse = await cartRepo?.updateCart(event.productId!, event.combinationId,event.qty);
        if(updateCartResponse?.status == AppConstants.STATUS_SUCCESS) {
          yield CartUpdated(updateCartResponse!.data!);
        } else {
          yield CartError(updateCartResponse!.message!);
        }
      }
      catch(e,stacktrace) {
        print('error caught: $e');
        print("stacktrace:" + stacktrace.toString());
        yield CartError("Some Error Occurred");
      }
      // on Error {
      //   yield const CartError("Couldn't fetch weather. okkkkkk Is the device online?");
      // }
    }


    else if (event is ApplyCoupon) {
      try {
        final applyCouponResponse = await cartRepo!.applyCoupon(event.coupon!);
        if(applyCouponResponse.status == AppConstants.STATUS_SUCCESS) {
          yield CouponApplied(applyCouponResponse.data!);
        } else {
          yield CartCouponError(applyCouponResponse.message!);
        }
      } on Error {
        yield const CartCouponError("Couldn't fetch weather. Is the device online?");
      }
    }
  }
}
