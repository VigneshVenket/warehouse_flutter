import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_kundol/api/responses/add_address_response.dart';
import 'package:flutter_kundol/api/responses/add_review_response.dart';
import 'package:flutter_kundol/api/responses/banners_response.dart';
import 'package:flutter_kundol/api/responses/cart_response.dart';
import 'package:flutter_kundol/api/responses/categories_response.dart';
import 'package:flutter_kundol/api/responses/check_email_response.dart';
import 'package:flutter_kundol/api/responses/contact_us_response.dart';
import 'package:flutter_kundol/api/responses/countries_response.dart';
import 'package:flutter_kundol/api/responses/currencies_response.dart';
import 'package:flutter_kundol/api/responses/delete_address_response.dart';
import 'package:flutter_kundol/api/responses/delete_cart_response.dart';
import 'package:flutter_kundol/api/responses/filters_response.dart';
import 'package:flutter_kundol/api/responses/forgot_password_response.dart';
import 'package:flutter_kundol/api/responses/get_address_response.dart';
import 'package:flutter_kundol/api/responses/get_page_response.dart';
import 'package:flutter_kundol/api/responses/get_wishlist_on_start_response.dart';
import 'package:flutter_kundol/api/responses/languages_response.dart';
import 'package:flutter_kundol/api/responses/login_response.dart';
import 'package:flutter_kundol/api/responses/logout_response.dart';
import 'package:flutter_kundol/api/responses/nearest_warehouse_response.dart';
import 'package:flutter_kundol/api/responses/order_place_response.dart';
import 'package:flutter_kundol/api/responses/order_shipment_cancel_response.dart';
import 'package:flutter_kundol/api/responses/order_shipment_return_response.dart';
import 'package:flutter_kundol/api/responses/orders_response.dart';
import 'package:flutter_kundol/api/responses/payment_method_response.dart';
import 'package:flutter_kundol/api/responses/product_detail_response.dart';
import 'package:flutter_kundol/api/responses/products_response.dart';
import 'package:flutter_kundol/api/responses/profile_address_response.dart';
import 'package:flutter_kundol/api/responses/quantity_response.dart';
import 'package:flutter_kundol/api/responses/redeem_response.dart';
import 'package:flutter_kundol/api/responses/register_response.dart';
import 'package:flutter_kundol/api/responses/reviews_response.dart';
import 'package:flutter_kundol/api/responses/reward_point_response.dart';
import 'package:flutter_kundol/api/responses/settings_response.dart';
import 'package:flutter_kundol/api/responses/shipment_city.dart';
import 'package:flutter_kundol/api/responses/shipment_creation_response.dart';
import 'package:flutter_kundol/api/responses/shipment_track_response.dart';
import 'package:flutter_kundol/api/responses/shipping_cost_response.dart';
import 'package:flutter_kundol/api/responses/tax_response.dart';
import 'package:flutter_kundol/api/responses/update_cart_response.dart';
import 'package:flutter_kundol/api/responses/update_profile_response.dart';
import 'package:flutter_kundol/api/responses/user_response.dart';
import 'package:flutter_kundol/api/responses/waybill_response.dart';
import 'package:flutter_kundol/api/responses/wishlist_detail_response.dart';
import 'package:flutter_kundol/constants/app_cart.dart';
import 'package:flutter_kundol/constants/app_config.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/models/add_to_cart/add_to_cart.dart';
import 'package:flutter_kundol/models/coupon_response.dart';
import '../models/cityy.dart';
import '../models/countryy.dart';
import '../models/reward_des.dart';
import '../models/reward_points.dart';
import '../models/shipment_creation.dart';
import '../models/shipmentcity.dart';
import '../models/statee.dart';
import '../models/total_wallet_data.dart';
import '../models/wallet_data.dart';
import 'logging_interceptor.dart';

class ApiProvider {
  final String _baseUrl = "${AppConfig.ECOMMERCE_URL}/api/client/";
  static String imgThumbnailUrlString = "${AppConfig.ECOMMERCE_URL}/gallary/thumbnail";
  static String imgMediumUrlString = "${AppConfig.ECOMMERCE_URL}/gallary/medium";
  static String imgLargeUrlString = "${AppConfig.ECOMMERCE_URL}/gallary/large";

  Dio? _dio;

  ApiProvider() {
    BaseOptions options = BaseOptions(
        receiveTimeout: Duration(milliseconds: 5000),
        connectTimeout: Duration(milliseconds: 5000),
        validateStatus: (status) => true,
        followRedirects: false);
    _dio = Dio(options);
    _dio?.options.headers.addAll({
      'clientid': AppConfig.CONSUMER_KEY,
      'clientsecret': AppConfig.CONSUMER_SECRET,
      'content-type': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      'authorization':
          AppData.accessToken == null ? "" : 'Bearer ${AppData.accessToken}',
    });
    _dio?.interceptors.add(LoggingInterceptor());
  }

  Future<WarehouseResponse> getNearestWarehouse(String address) async {
    try {
      Response response =
          await _dio!.get('${_baseUrl}nearestWarehouse?address=$address');
      return WarehouseResponse.fromJson(response.data);
    } catch (error) {
      return WarehouseResponse.withError(_handleError(error as TypeError));
    }
  }

  Future<ShippingCostResponse> getShippingCost(String md, String ss,
      String dPin, String oPin, double cgm, String pt, double cod) async {
    // try{
    Response response = await _dio!.get('${_baseUrl}shippingCost?'
        'md=${md}&ss=${ss}&d_pin=${dPin}&o_pin=${oPin}&cgm=${cgm}&pt=${pt}&cod=${cod}');
    // final List<dynamic> data = json.decode(response.data);
    return ShippingCostResponse.fromJson(response.data);
    // }catch(error){
    //   return ;
    // }
  }

  Future<WaybillResponse> getWaybill() async {
    Response response = await _dio!.get('${_baseUrl}waybillFetch?count=1');
    return WaybillResponse.fromJson(response.data);
  }

  Future<ShipmentCreateResponse> shipmentCreation(
      ShipmentCreateData shipmentCreateData) async {
    Response response = await _dio!.post('${_baseUrl}shipmentCreate',
        data: jsonEncode(shipmentCreateData.toJson()));
    return ShipmentCreateResponse.fromJson(response.data);
  }

  Future<ShipmentTrackResponse> getShipmentTrack(String waybill) async {
    Response response =
        await _dio!.get('${_baseUrl}shipmentTrack?waybill=$waybill');
    return ShipmentTrackResponse.fromJson(response.data);
  }

  Future<TaxRateResponse> getTax(int stateId) async {
    Response response =
        await _dio!.get('${_baseUrl}tax_rate?state_id=$stateId&currency=1');
    return TaxRateResponse.fromJson(response.data);
  }


  Future<CheckEmailResponse> checkEmail(String email) async {
    try {
      Response response = await _dio!.post("https://warehouse.fronseye.com/api/check-email?email=$email");
      print("Response $response");
      return CheckEmailResponse.fromJson(response.data);
    } catch (error) {
      return CheckEmailResponse.withError(_handleError(error as TypeError));
    }
  }

  Future<OrderShipmentCancelResponse> cancelOrderShipment(int order_id,String waybill) async {
    try {
      Response response = await _dio!.post("${_baseUrl}order-shipment-cancel/${order_id}/${waybill}?order_status=Cancel");
      print("Response $response");
      return OrderShipmentCancelResponse.fromJson(response.data);
    } catch (error) {
      return OrderShipmentCancelResponse.withError(_handleError(error as TypeError));
    }
  }



  Future<SettingsResponse> getSettings() async {
    try {
      Response response = await _dio!.get("${_baseUrl}setting?app_setting=1");
      return SettingsResponse.fromJson(response.data);
    } catch (error) {
      return SettingsResponse.withError(_handleError(error as TypeError));
    }
  }

  Future<BannersResponse> getBanners() async {
    try {
      Response response = await _dio!.get(
          "${_baseUrl}banner?getBannerNavigation=1&getBannerMedia=1&limit=100&sortBy=title&sortType=DESC&currency=${AppData.currency?.currencyId}&language_id=${AppData.language?.id}");
      return BannersResponse.fromJson(response.data);
    } catch (error) {
      return BannersResponse.withError(_handleError(error as TypeError));
    }
  }

  Future<CategoriesResponse> getCategories() async {
    try {
      Response response = await _dio!.get(
          "${_baseUrl}category?getDetail=1&page=1&limit=100&getMedia=1&language_id=${AppData.language?.id}&sortBy=id&sortType=ASC&currency=${AppData.currency?.currencyId}");
      return CategoriesResponse.fromJson(response.data);
    } catch (error) {
      return CategoriesResponse.withError(_handleError(error as TypeError));
    }
  }

  Future<ProductsResponse> getProducts(int pageNo) async {
    try {
      Response response = await _dio!.get(
          "${_baseUrl}products?limit=10&getCategory=1&getDetail=1&language_id=${AppData.language?.id}&currency=${AppData.currency?.currencyId}&stock=1&sortType=ASC&page=$pageNo");
      print(response);
      return ProductsResponse.fromJson(response.data);
    } catch (error) {
      return ProductsResponse.withError(_handleError(error as TypeError));
    }
  }

  Future<ProductsResponse> getTopSellingProducts(int pageNo) async {
    try {
      Response response = await _dio!.get(
          "${_baseUrl}products?limit=10&getCategory=1&getDetail=1&language_id=${AppData.language?.id}&currency=${AppData.currency?.currencyId}&stock=1&sortType=ASC&topSelling=1&page=$pageNo");
      return ProductsResponse.fromJson(response.data);
    } catch (error) {
      return ProductsResponse.withError(_handleError(error as TypeError));
    }
  }

  Future<ProductsResponse> getDealsProducts(int pageNo) async {
    try {
      Response response = await _dio!.get(
          "${_baseUrl}products?limit=10&getCategory=1&getDetail=1&language_id=${AppData.language?.id}&currency=${AppData.currency?.currencyId}&stock=1&sortType=ASC&sortBy=discount_price&page=$pageNo");
      return ProductsResponse.fromJson(response.data);
    } catch (error) {
      return ProductsResponse.withError(_handleError(error as TypeError));
    }
  }

  Future<ProductsResponse> getFeaturedProducts(int pageNo,
      {String? variation,
      String? attributes,
      String? variation_name,
      String? priceFrom,
      String? priceTo}) async {
    try {
      Response response = await _dio!.get(
          "${_baseUrl}products?limit=10&getCategory=1&getDetail=1&language_id=${AppData.language?.id}&currency=${AppData.currency?.currencyId}&stock=1&sortType=ASC&isFeatured=1&page=$pageNo" +
              "&variations=" +
              variation! +
              "&variation_name=" +
              variation_name! +
              "&attributes=" +
              attributes! +
              "&price_to=" +
              priceTo! +
              "&price_from=" +
              priceFrom!);
      return ProductsResponse.fromJson(response.data);
    } catch (error) {
      return ProductsResponse.withError(_handleError(error as TypeError));
    }
  }

  Future<ProductsResponse> getNewArrivalProducts(int pageNo, String cat) async {
    try {
      Response response = await _dio!.get(
          "${_baseUrl}products?limit=12&getCategory=1&getDetail=1&language_id=${AppData.language?.id}&sortBy=id&sortType=DESC&currency=${AppData.currency?.currencyId}");
      return ProductsResponse.fromJson(response.data);
    } catch (error) {
      return ProductsResponse.withError(_handleError(error as TypeError));
    }
  }

  // Future<CountryResponse> getCountry() async {
  //   try {
  //
  //     Response response = await _dio!.get("${_baseUrl}country?language_id=${AppData.language?.id}&currency=${AppData.currency?.currencyId}&getAllData=1");
  //     print("Country response ${response.data}");
  //     return CountryResponse.fromJson(response.data);
  //   } catch (error) {
  //     return null!;
  //    // return CountryResponse.withError(_handleError(error as TypeError));
  //   }
  // }

  // Future<StateResponse> getState() async {
  //   try {
  //
  //     Response response = await _dio!.get("${_baseUrl}state?language_id=${AppData.language?.id}&currency=${AppData.currency?.currencyId}&country_id=108&getAllData=1");
  //     print("State response ${response.data}");
  //     return StateResponse.fromJson(response.data);
  //   } catch (error) {
  //     return null!;
  //     // return CountryResponse.withError(_handleError(error as TypeError));
  //   }
  // }

  // Future<CityResponse> getCity() async {
  //   try {
  //
  //     Response response = await _dio!.get("${_baseUrl}city?language_id=${AppData.language?.id}&currency=${AppData.currency?.currencyId}&state_id=3755&getAllData=1");
  //     print("City response ${response.data}");
  //     return CityResponse.fromJson(response.data);
  //   } catch (error) {
  //     return null!;
  //     // return CountryResponse.withError(_handleError(error as TypeError));
  //   }
  // }

  Future<CountryyResponse> getCountryy() async {
    try {
      Response response = await _dio!.get(
          "${_baseUrl}country?getAllData=1&language_id=${AppData.language?.id}&currency=${AppData.currency?.currencyId}");
      print("country response ${response.data}");
      return CountryyResponse.fromJson(response.data);
    } catch (error) {
      return CountryyResponse.withError(_handleError(error as TypeError));
    }
  }

  Future<StateeResponse> getStatee(int? value) async {
    try {
      Response response = await _dio!.get(
          "${_baseUrl}state?country_id=${value}&getAllData=1&language_id=${AppData.language?.id}&currency=${AppData.currency?.currencyId}");
      print("state response ${response.data}");
      return StateeResponse.fromJson(response.data);
    } catch (error) {
      return StateeResponse.withError(_handleError(error as TypeError));
    }
  }

  Future<CityyResponse> getCityy(int? countryvalue) async {
    try {
      Response response = await _dio!.get(
          "${_baseUrl}city?state_id=${countryvalue}&getAllData=1&language_id=${AppData.language?.id}&currency=${AppData.currency?.currencyId}");
      print("Cityy response ${response.data}");
      return CityyResponse.fromJson(response.data);
    } catch (error) {
      return CityyResponse.withError(_handleError(error as TypeError));
    }
  }

  Future<WalletResponse> getWallet() async {
    try {
      Response response = await _dio!.get(
          "${_baseUrl}wallet?language_id=${AppData.language?.id}&currency=${AppData.currency?.currencyId}");
      print("wallet response ${response.data}");
      return WalletResponse.fromJson(response.data);
    } catch (error) {
      return WalletResponse.withError(_handleError(error as TypeError));
    }
  }

  Future<TotalResponse> getTotal() async {
    // try {
    Response response = await _dio!.get(
        "${_baseUrl}wallet?language_id=${AppData.language?.id}&currency=${AppData.currency?.currencyId}&total=1");
    print("total response ${response.data}");
    return TotalResponse.fromJson(response.data);
    // } catch (error) {
    //  return TotalResponse.withError(_handleError(error as TypeError));
    // }
  }

  Future<ShipmentCitysResponse> getShipment(String? city) async {
    try {
      Response response =
          await _dio!.post("${_baseUrl}shippingWithCity?delivery_city=${city}",
              data: jsonEncode({
                "delivery_city": city,
              }));
      return ShipmentCitysResponse.fromJson(response.data);
    } catch (error) {
      return null!;
      // return ShipmentCitysResponse.withError(_handleError(error as TypeError));
    }
  }

  Future<UpdateProfileAddressResponse> updateProfileAddress(
      int id,
      String firstName,
      String lastName,
      String gender,
      String dob,
      String lat,
      String lng,
      String phone) async {
    try {
      Response response =
          await _dio!.put("${_baseUrl}customer_address_book/$id",
              data: jsonEncode({
                "is_default": 1,
                "first_name": firstName,
                "last_name": lastName,
                "gender": gender,
                "dob": dob,
                "latlong": "$lat,$lng",
                "phone": phone,
                "type": "profile"
              }));
      print("update adress response ${response}");
      return UpdateProfileAddressResponse.fromJson(response.data);
    } catch (error) {
      return UpdateProfileAddressResponse.withError(
          _handleError(error as TypeError));
    }
  }

  Future<UpdateUserResponse> updateUser(
      String firstName, String lastName) async {
    try {
      Response response = await _dio!.put(
          "${_baseUrl}profile/${AppData.user?.id}?first_name=$firstName&last_name=$lastName&type=profile");
      return UpdateUserResponse.fromJson(response.data);
    } catch (error) {
      return UpdateUserResponse.withError(_handleError(error as TypeError));
    }
  }

// Future<ShipmentCityResponse> getShipment(String city) async {
//     try {
//       Response response = await _dio!.post("${_baseUrl}shippingWithCity?delivery_city=Bounty Hall",
//           data: jsonEncode({
//            "delivery_city": "Bounty Hall"
//           }));
//       print("shipmentwithcity response ${response.data}");
//       return ShipmentCityResponse.fromJson(response.data);
//     } catch (error) {
//       return ShipmentCityResponse.withError(_handleError(error as TypeError));
//     }
//   }

  Future<RewardnResponse> getRewardn() async {
    try {
      Response response = await _dio!.get(
          "${_baseUrl}points?language_id=${AppData.language?.id}&currency=${AppData.currency?.currencyId}&sum=1");
      print("reward response ${response.data}");
      return RewardnResponse.fromJson(response.data);
    } catch (error) {
      return null!;
      //  return RewardTotalResponse.withError(_handleError(error as TypeError));
    }
  }

  Future<RewardDes> getRewarddes() async {
    try {
      Response response = await _dio!.get(
          "${_baseUrl}points?language_id=${AppData.language?.id}&currency=${AppData.currency?.currencyId}");
      print("reward_des response ${response.data}");
      return RewardDes.fromJson(response.data);
    } catch (error) {
      return null!;
      //  return RewardTotalResponse.withError(_handleError(error as TypeError));
    }
  }

  Future<ProductDetailResponse> getProductById(String productId) async {
    try {
      Response response = await _dio!.get(
          "${_baseUrl}products/$productId?getCategory=1&getDetail=1&language_id=${AppData.language?.id}&currency=${AppData.currency?.currencyId}&stock=1");
      return ProductDetailResponse.fromJson(response.data);
    } catch (error) {
      return ProductDetailResponse.withError(_handleError(error as TypeError));
    }
  }

  Future<ProductsResponse> getSearchProducts(String keyword, int pageNo,
      {String? variation,
      String? attributes,
      String? variation_name,
      String? priceFrom,
      String? priceTo}) async {
    try {
      Response response = await _dio!.get(
          "${_baseUrl}products?limit=100&getCategory=1&getDetail=1&language_id=${AppData.language?.id}&currency=${AppData.currency?.currencyId}&&stock=1&page=$pageNo&searchParameter=$keyword" +
              "&variations=" +
              variation! +
              "&variation_name=" +
              variation_name! +
              "&attributes=" +
              attributes! +
              "&price_to=" +
              priceTo! +
              "&price_from=" +
              priceFrom!);
      return ProductsResponse.fromJson(response.data);
    } catch (error) {
      return ProductsResponse.withError(_handleError(error as TypeError));
    }
  }

  // Future<ProductsResponse> getProductsByCat(int pageNo, int categoryId,
  //     String sortBy, String sortType, String filters) async {
  //   try {
  //     Response response = await _dio!.get("${_baseUrl}products?limit=10&getCategory=1&getDetail=1&language_id=${AppData.language?.id}&currency=${AppData.currency?.currencyId}&stock=1&sortType=$sortType&page=$pageNo&productCategories=$categoryId&sortBy=$sortBy&variations=$filters");
  //     return ProductsResponse.fromJson(response.data);
  //   } catch (error) {
  //     return ProductsResponse.withError(_handleError(error as TypeError));
  //   }
  // }

  Future<ProductsResponse> getProductsByCat(
      int pageNo, String categoryId, String sortBy, String sortType,
      {String? variation,
      String? attributes,
      String? variation_name,
      String? priceFrom,
      String? priceTo}) async {
    try {
      Response response = await _dio!.get(_baseUrl +
          "products?limit=10&getCategory=1&getDetail=1&language_id=${AppData.language?.id}&currency=${AppData.currency?.currencyId}&stock=1&sortType=" +
          sortType +
          "&page=" +
          pageNo.toString() +
          "&productCategories=" +
          categoryId.toString() +
          "&sortBy=" +
          sortBy +
          "&variations=" +
          variation! +
          "&variation_name=" +
          variation_name! +
          "&attributes=" +
          attributes! +
          "&price_to=" +
          priceTo! +
          "&price_from=" +
          priceFrom!);
      return ProductsResponse.fromJson(response.data);
    } catch (error) {
      return ProductsResponse.withError(_handleError(TypeError()));
    }
  }

  Future<LoginResponse> loginUser(String email, String password) async {
    try {
      Response response = await _dio!.post("${_baseUrl}customer_login",
          data: jsonEncode({
            "email": email,
            "password": password,
            "session_id": AppData.sessionId
          }));
      if (response.statusCode == 200) {
        return LoginResponse.fromJson(response.data);
      } else {
        return LoginResponse.fromErrorJson(response.data);
      }
    } catch (error) {
      return LoginResponse.withError(_handleError(error as TypeError));
    }
  }

  Future<LoginResponse> loginWithFacebook(String accessToken) async {
    try {
      Response response = await _dio!.get(
          "${_baseUrl}customer_login/facebook/callback?code=$accessToken&scope=public_profile&authuser=email&prompt=prompt&fromApp=1");
      return LoginResponse.fromJson(response.data);
    } catch (error) {
      return LoginResponse.withError(_handleError(error as TypeError));
    }
  }

  Future<LoginResponse> loginWithGoogle(String accessToken) async {
    try {
      Response response = await _dio!.get("${_baseUrl}customer_login/google/callback?code=$accessToken&scope=public_profile&authuser=email&prompt=prompt&fromApp=1");
      return LoginResponse.fromJson(response.data);
    } catch (error) {
      return LoginResponse.withError(_handleError(error as TypeError));
    }
  }

  Future<RegisterResponse> registerUser(String firstName, String lastName,
      String email, String password, String confirmPassword,String phoneNumber) async {
    try {
      Response response = await _dio!.post("${_baseUrl}customer_register",
          data: jsonEncode({
            "email": email,
            "password": password,
            "first_name": firstName,
            "last_name": lastName,
            "confirm_password": confirmPassword,
            "phone_no":phoneNumber,
            "status": "1",
            "session_id": AppData.sessionId
          }));
      if (response.statusCode == 200) {
        return RegisterResponse.fromJson(response.data);
      } else {
        return RegisterResponse.fromErrorJson(response.data);
      }
    } catch (error) {
      return RegisterResponse.withError(_handleError(error as TypeError));
    }
  }

  Future<LogoutResponse> doLogout() async {
    try {
      Response response = await _dio!.post("${_baseUrl}customer_logout");
      print(response);
      return LogoutResponse.fromJson(response.data);
    } catch (error) {
      return LogoutResponse.withError(_handleError(error as TypeError));
    }
  }

  Future<AddToCartResponse> addToCart(
      int productId, int qty, int? combinationId) async {
    try {
      Response response = await _dio!.post(
          "${_baseUrl}cart${(AppData.user == null) ? "/guest/store" : ""}?currency=${AppData.currency?.currencyId}&language_id=${AppData.language?.id}&product_id=$productId&qty=$qty&product_combination_id=${(combinationId == null) ? "" : combinationId.toString()}${AppData.sessionId == null ? "" : "&session_id=${AppData.sessionId!}"}&is_from=null");
      getCart();
      return AddToCartResponse.fromJson(response.data);
    } catch (error) {
      return AddToCartResponse.withError(_handleError(error as TypeError));
    }
  }

  Future<CouponResponse> applyCoupon(String coupon) async {
    try {
      Response response = await _dio!.post(
          "${_baseUrl}coupon?coupon_code=$coupon&currency=${AppData.currency?.currencyId}&language_id=${AppData.language?.id}");
      return CouponResponse.fromJson(response.data);
    } catch (error) {
      return CouponResponse.withError(_handleError(error as TypeError));
    }
  }

  Future<QuantityResponse> getQuantity(
      int productId, String productType, int combinationId) async {
    try {
      Response response = await _dio!.get(
          "${_baseUrl}available_qty?product_id=$productId&product_type=$productType&product_combination_id=$combinationId&currency=${AppData.currency?.currencyId}&language_id=${AppData.language?.id}");
      return QuantityResponse.fromJson(response.data);
    } catch (error) {
      return QuantityResponse.withError(_handleError(error as TypeError));
    }
  }

  Future<CartResponse> getCart() async {
    try {
      Response response = await _dio!.get(
          "${_baseUrl}cart${(AppData.user == null) ? "/guest/get?session_id=${AppData.sessionId}&" : "?"}currency=${AppData.currency?.currencyId}&language_id=${AppData.language?.id}");

      return CartResponse.fromJson(response.data);
    } catch (error) {
      return CartResponse.withError(_handleError(error as TypeError));
    }
  }

  Future<DeleteCartResponse> deleteCartItem(
      int? productId, int? combinationId) async {
    try {
      Response response = await _dio!.delete(_baseUrl +
          "cart" +
          ((AppData.user == null)
              ? "/guest/delete?session_id=" + AppData.sessionId! + "&"
              : "/delete?") +
          "product_id=" +
          productId.toString() +
          ((combinationId == null)
              ? ""
              : "&product_combination_id=" + combinationId.toString()) +
          "&currency=${AppData.currency?.currencyId}&language_id=${AppData.language?.id}");
      return DeleteCartResponse.fromJson(response.data);
    } catch (error) {
      return DeleteCartResponse.withError(_handleError(error as TypeError));
    }
  }

  // Future<UpdateCartResponse> updateCart(
  //     int? productId, int? combinationId, int qty) async {
  //   try {
  //     Response response = await _dio!.post(_baseUrl +
  //         "cart?session_id=&product_id=" +
  //         productId.toString() +
  //         "&qty=" +
  //         qty.toString() +
  //         "&product_combination_id=" +
  //         ((combinationId == null) ? "" : combinationId.toString()) +
  //         "&is_from=cart");
  //     return UpdateCartResponse.fromJson(response.data);
  //   } catch (error) {
  //     return UpdateCartResponse.withError(_handleError(error as TypeError));
  //   }
  // }


  Future<UpdateCartResponse> updateCart(
      int? productId, var combinationId, int qty) async {
    try {
      Response response = await _dio!.post(
          "${_baseUrl}cart${(AppData.user == null) ? "/guest/store" : ""}?currency=${AppData.currency?.currencyId}&language_id=${AppData.language?.id}&product_id=$productId&qty=$qty&product_combination_id=${(combinationId == null) ? "" : combinationId.toString()}${AppData.sessionId == null ? "" : "&session_id=${AppData.sessionId!}"}&is_from=cart");
      return UpdateCartResponse.fromJson(response.data);
    } catch (error) {
      return UpdateCartResponse.withError(_handleError(error as TypeError));
    }
  }

  Future<GetAddressResponse> getCustomerAddress() async {
    try {
      Response response = await _dio!.get(
          "${_baseUrl}customer_address_book?currency=${AppData.currency?.currencyId}&language_id=${AppData.language?.id}");
      print("get address response");
      print(response);
      return GetAddressResponse.fromJson(response.data);
    } catch (error) {
      return GetAddressResponse.withError(_handleError(error as TypeError));
    }
  }

  Future<DeleteAddressResponse> deleteCustomerAddress(int addressId) async {
    try {
      Response response = await _dio!.delete(
          "${_baseUrl}customer_address_book/$addressId?currency=${AppData.currency?.currencyId}&language_id=${AppData.language?.id}");
      return DeleteAddressResponse.fromJson(response.data);
    } catch (error) {
      return DeleteAddressResponse.withError(_handleError(error as TypeError));
    }
  }

  Future<AddAddressResponse> addCustomerAddress(
      String firstName,
      String lastName,
      String gender,
      String company,
      String streetAddress,
      String suburb,
      String postCode,
      String dob,
      //  String city,
      var countryId,
      var stateId,
      var city,
      String lat,
      String lng,
      String phone) async {
    try {
      Response response = await _dio!.post("${_baseUrl}customer_address_book",
          data: jsonEncode({
            "first_name": firstName,
            "last_name": lastName,
            "gender": gender,
            "company": company,
            "street_address": streetAddress,
            "suburb": suburb,
            "postcode": postCode,
            "dob": dob,
            //  "city": city,
            "country_id": countryId,
            "state_id": stateId,
            "city": city.toString(),
            "latlong": "$lat,$lng",
            "is_default": 1,
            "phone": phone,
          }));
      print("add custumer adress response ${response}");
      return AddAddressResponse.fromJson(response.data);
    } catch (error) {
      return AddAddressResponse.withError(_handleError(error as TypeError));
    }
  }

  Future<AddAddressResponse> updateCustomerAddress(
      int id,
      String firstName,
      String lastName,
      String gender,
      String company,
      String streetAddress,
      String suburb,
      String postCode,
      String dob,
      //  String city,
      var countryId,
      var stateId,
      var city,
      String lat,
      String lng,
      String phone) async {
    try {
      Response response =
          await _dio!.put("${_baseUrl}customer_address_book/$id",
              data: jsonEncode({
                "first_name": firstName,
                "last_name": lastName,
                "gender": gender,
                "company": company,
                "street_address": streetAddress,
                "suburb": suburb,
                "postcode": postCode,
                "dob": dob,
                //  "city": city,
                "country_id": countryId,
                "state_id": stateId,
                "city": city.toString(),
                "latlong": "$lat,$lng",
                "is_default": 1,
                "phone": phone,
              }));
      print("update adress response ${response}");
      return AddAddressResponse.fromJson(response.data);
    } catch (error) {
      return AddAddressResponse.withError(_handleError(error as TypeError));
    }
  }

  Future<AddAddressResponse> setDefaultCustomerAddress(
      int addressBookID,
      String firstName,
      String lastName,
      String gender,
      String company,
      String streetAddress,
      String suburb,
      String postCode,
      String dob,
      //  String city,
      var countryId,
      var stateId,
      var city,
      String lat,
      String lng,
      int isdefault,
      String phone) async {
    try {
      Response response =
          await _dio!.put("${_baseUrl}customer_address_book/$addressBookID",
              data: jsonEncode({
                "first_name": firstName,
                "last_name": lastName,
                "gender": gender,
                "company": company,
                "street_address": streetAddress,
                "suburb": suburb,
                "postcode": postCode,
                "dob": dob,
                // "city": city,
                "country_id": 162,
                "state_id": 167,
                "city": 169.toString(),
                "latlong": "$lat,$lng",
                "is_default": isdefault,
                "phone": phone,
              }));
      print("default adress response ${response}");
      return AddAddressResponse.fromJson(response.data);
    } catch (error) {
      return AddAddressResponse.withError(_handleError(error as TypeError));
    }
  }

  Future<OrderPlaceResponse> placeOrder(
      String billingFirstName,
      String billingLastName,
      String billingStreetAddress,
      String billingCity,
      String billingPostCode,
      int billingCountry,
      int billingState,
      String billingPhone,
      String deliveryFirstName,
      String deliveryLastName,
      String deliveryStreetAddress,
      String deliveryCity,
      String deliveryPostCode,
      int deliveryCountry,
      int deliveryState,
      String deliveryPhone,
      int currencyId,
      int languageId,
      String paymentMethod,
      String latLng,
      String cardNumber,
      String cvc,
      String expMonth,
      String expYear,
      String coupon_code,
      String waybill,
      String razor_pay_transaction_id,
      double shipping_cost,
      String gstNumber,
      double gst_discount,
      List<ShipmentsData> shipments,
      PickupLocation pickupLocation

      ) async {
    try {
      Response response = await _dio!.post("${_baseUrl}order",
          data: jsonEncode({
            "billing_first_name": billingFirstName,
            "billing_last_name": billingLastName,
            "billing_street_aadress": billingStreetAddress,
            "billing_city": billingCity,
            "billing_postcode": billingPostCode,
            "billing_country": billingCountry,
            "billing_state": billingState,
            "billing_phone": billingPhone,
            "delivery_first_name": deliveryFirstName,
            "delivery_last_name": deliveryLastName,
            "delivery_street_aadress": deliveryStreetAddress,
            "delivery_city": deliveryCity,
            "delivery_postcode": deliveryPostCode,
            "delivery_country": deliveryCountry,
            "delivery_state": deliveryState,
            "delivery_phone": deliveryPhone,
            "currency_id": currencyId,
            "language_id": languageId,
            "session_id": (AppData.sessionId == null) ? "" : AppData.sessionId,
            "payment_method": paymentMethod,
            "latlong": latLng,
            "payment_id": 0,
            "cc_cvc": cvc,
            "cc_expiry_month": expMonth,
            "cc_expiry_year": expYear,
            "cc_number": cardNumber,
            "coupon_code": coupon_code,
            "waybill": waybill,
            "razor_pay_transaction_id":razor_pay_transaction_id,
            "shipping_cost":shipping_cost,
            "gstNumber":gstNumber,
            "gst_discount":gst_discount,
            "shipments":shipments,
            "pickup_location":pickupLocation
          }));
      return OrderPlaceResponse.fromJson(response.data);
    } catch (error) {
      return OrderPlaceResponse.withError(_handleError(error as TypeError));
    }
  }

  Future<GetPageResponse> getPage(int pageNo) async {
    try {
      Response response = await _dio!.get("${_baseUrl}pages/$pageNo");
      return GetPageResponse.fromJson(response.data);
    } catch (error) {
      return GetPageResponse.withError(_handleError(error as TypeError));
    }
  }

  Future<OrdersResponse> getOrders() async {
    try {
      Response response = await _dio!.get(
          "${_baseUrl}customer/order?orderDetail=1&productDetail=1&currency=${AppData.currency?.currencyId}");
      return OrdersResponse.fromJson(response.data);
    } catch (error) {
      return OrdersResponse.withError(_handleError(error as TypeError));
    }
  }

  Future<OrdersResponse> getOrderById(int Id) async {
    try {
      Response response = await _dio!.get(
          "${_baseUrl}customer/order/'+ $Id +'?orderDetail=1&language_id=${AppData.language!.id}&productDetail=1&billing_country=1&billing_state=1&delivery_country=1&delivery_state=1&currency=${AppData.currency?.currencyId}'");
      return OrdersResponse.fromJson(response.data);
    } catch (error) {
      return OrdersResponse.withError(_handleError(error as TypeError));
    }
  }

  Future<ReviewsResponse> getReviews(int productId) async {
    try {
      Response response = await _dio!.get(
          "${_baseUrl}review?product_id=$productId&language_id=1&customer=1&currency=${AppData.currency?.currencyId}");

      return ReviewsResponse.fromJson(response.data);
    } catch (error) {
      return ReviewsResponse.withError(_handleError(error as TypeError));
    }
  }

  Future<ForgotPasswordResponse> forgotPassword(String email) async {
    try {
      Response response = await _dio!.post("${_baseUrl}forget_password",
          data: jsonEncode({"email": email}));
      return ForgotPasswordResponse.fromJson(response.data);
    } catch (error) {
      return ForgotPasswordResponse.withError(_handleError(error as TypeError));
    }
  }

  Future<AddReviewResponse> addReview(
      int productId, String comment, double rating, String title) async {
    try {
      Response response = await _dio!.post("${_baseUrl}review",
          data: jsonEncode({
            "product_id": productId,
            "comment": comment,
            "rating": rating,
            "title": title
          }));
      print(response.data);
      return AddReviewResponse.fromJson(response.data);
    } catch (error) {
      print(error);
      return AddReviewResponse.withError(_handleError(error as TypeError));
    }
  }

  Future<GetWishlistOnStartResponse> getWishlistOnStart() async {
    try {
      Response response = await _dio!
          .get("${_baseUrl}wishlist?currency=${AppData.currency?.currencyId}");
      return GetWishlistOnStartResponse.fromJson(response.data);
    } catch (error) {
      return GetWishlistOnStartResponse.withError(
          _handleError(error as TypeError));
    }
  }

  Future<GetWishlistOnStartResponse> likeProduct(int productId) async {
    print("------wish---------");
    print(GetWishlistOnStartResponse);
    try {
      Response response =
          await _dio!.post("${_baseUrl}wishlist?product_id=$productId");
      return GetWishlistOnStartResponse.fromJson(response.data);
    } catch (error) {
      return GetWishlistOnStartResponse.withError(
          _handleError(error as TypeError));
    }
  }

  Future<GetWishlistOnStartResponse> unLikeProduct(int wishlistId) async {
    try {
      Response response = await _dio!.delete(
          "${_baseUrl}wishlist/$wishlistId?currency=${AppData.currency?.currencyId}");
      return GetWishlistOnStartResponse.fromJson(response.data);
    } catch (error) {
      return GetWishlistOnStartResponse.withError(
          _handleError(error as TypeError));
    }
  }

  Future<WishlistDetailResponse> getWishlistProducts(int pageNo) async {
    try {
      Response response = await _dio!.get(
          "${_baseUrl}wishlist?limit=10&getCategory=1&products=1&getDetail=1&language_id=1&currency=${AppData.currency?.currencyId}&stock=1&page=$pageNo");
      return WishlistDetailResponse.fromJson(response.data);
    } catch (error) {
      return WishlistDetailResponse.withError(_handleError(error as TypeError));
    }
  }

  Future<ContactUsResponse> submitContactUs(
      String firstName, String lastName, String email, String message) async {
    try {
      Response response = await _dio!.post(
          "${_baseUrl}contact-us?first_name=$firstName&last_name=$lastName&email=$email&message=$message");
      return ContactUsResponse.fromJson(response.data);
    } catch (error) {
      return ContactUsResponse.withError(_handleError(error as TypeError));
    }
  }

  Future<RewardPointsResponse> getRewardPoints() async {
    try {
      Response response = await _dio!
          .get("${_baseUrl}points?currency=${AppData.currency?.currencyId}");
      return RewardPointsResponse.fromJson(response.data);
    } catch (error) {
      return RewardPointsResponse.withError(_handleError(error as TypeError));
    }
  }

  Future<RedeemResponse> redeemRewardPoints() async {
    try {
      Response response = await _dio!
          .post("${_baseUrl}redeem?currency=${AppData.currency?.currencyId}");
      return RedeemResponse.fromJson(response.data);
    } catch (error) {
      return RedeemResponse.withError(_handleError(error as TypeError));
    }
  }

  Future<FiltersResponse> getFilters() async {
    try {
      Response response = await _dio!.get(
          "${_baseUrl}attributes?getVariation=1&getDetail=1&page=1&language_id=1&currency=${AppData.currency?.currencyId}");
      return FiltersResponse.fromJson(response.data);
    } catch (error) {
      return FiltersResponse.withError(_handleError(error as TypeError));
    }
  }

  Future<LanguagesResponse> getLanguages() async {
    try {
      Response response =
          await _dio!.get("${_baseUrl}language?page=1&limit=100");
      return LanguagesResponse.fromJson(response.data);
    } catch (error) {
      return LanguagesResponse.withError(_handleError(error as TypeError));
    }
  }

  Future<CurrenciesResponse> getCurrencies() async {
    try {
      Response response = await _dio!.get("${_baseUrl}currency");
      return CurrenciesResponse.fromJson(response.data);
    } catch (error) {
      return CurrenciesResponse.withError(_handleError(error as TypeError));
    }
  }

  Future<UpdateProfileResponse> updateProfile(String firstName, String lastName,
      String password, String confirmPassword) async {
    try {
      Response response = await _dio!.put(
          "${_baseUrl}profile/${AppData.user?.id}?first_name=$firstName&last_name=$lastName&password=$password&password_confirmation=$confirmPassword");
      return UpdateProfileResponse.fromJson(response.data);
    } catch (error) {
      return UpdateProfileResponse.withError(_handleError(error as TypeError));
    }
  }

  // Future<CountriesResponse> getCountries() async {
  //   try {
  //     Response response =
  //         await _dio!.get("${_baseUrl}country?limit=1000&getStates=1");
  //     print("country response ${response}");
  //     return CountriesResponse.fromJson(response.data);
  //   } catch (error) {
  //     return null!;
  //   //  return CountriesResponse.withError(_handleError(error as TypeError));
  //   }
  // }

  Future<PaymentMethodsResponse> getPaymentMethods() async {
    try {
      Response response = await _dio!.get("${_baseUrl}payment_method");
      print("Payment method response ${response}");
      return PaymentMethodsResponse.fromJson(response.data);
    } catch (error) {
      return PaymentMethodsResponse.withError(_handleError(error as TypeError));
    }
  }


  // Future<OrderShipmentReturnResponse> returnOrderShipment(
  //     String orderStatus,
  //     String orderReturnReason,
  //     String orderReturnComment,
  //     String returnAmount,
  //     List<File> returnImages,
  //     String upiId,
  //     int orderId,
  //     String waybillNumber) async {
  //   try {
  //     final uri = '${_baseUrl}order-shipment-cancel/$orderId/$waybillNumber';
  //
  //     // Create form data
  //     var formData = FormData();
  //
  //     formData.fields
  //       ..add(MapEntry('order_status', orderStatus))
  //       ..add(MapEntry('order_return_reason', orderReturnReason))
  //       ..add(MapEntry('order_return_comment', orderReturnComment))
  //       ..add(MapEntry('returnAmount', returnAmount))
  //       ..add(MapEntry('upi_id', upiId));
  //
  //     // List to hold filenames
  //     List<String> filenames = [];
  //
  //     // Add images to form data and collect filenames
  //     for (File image in returnImages) {
  //       String filename = image.path.split("/").last;
  //       filenames.add(filename);
  //       formData.files.add(MapEntry(
  //         'files', // This can be a temporary key for file upload
  //         await MultipartFile.fromFile(image.path, filename: filename),
  //       ));
  //     }
  //
  //     // Add filenames as a JSON array string
  //     formData.fields.add(MapEntry('return_images', jsonEncode(filenames)));
  //
  //     print(jsonEncode(filenames));
  //     // Print the contents of formData
  //     print('Fields:');
  //     formData.fields.forEach((entry) {
  //       print('${entry.key}: ${entry.value}');
  //     });
  //
  //     print('Files:');
  //     for (var fileEntry in formData.files) {
  //       var file = fileEntry.value as MultipartFile;
  //       print('${fileEntry.key}: ${file.filename} (${file.length} bytes)');
  //     }
  //
  //     // Send the POST request
  //     Response response = await _dio!.post(uri, data: formData);
  //
  //     return OrderShipmentReturnResponse.fromJson(response.data);
  //   } catch (error) {
  //     print('Error: $error');
  //     return OrderShipmentReturnResponse.withError(_handleError(error));
  //   }
  // }


  Future<OrderShipmentReturnResponse> returnOrderShipment(
      String orderStatus,
      String orderReturnReason,
      String orderReturnComment,
      String returnAmount,
      List<File> returnImages,
      String upiId,
      int orderId,
      String waybillNumber) async {
    try {
      final uri = '${_baseUrl}order-shipment-cancel/$orderId/$waybillNumber';

      // Create form data
      var formData = FormData();

      formData.fields
        ..add(MapEntry('order_status', orderStatus))
        ..add(MapEntry('order_return_reason', orderReturnReason))
        ..add(MapEntry('order_return_comment', orderReturnComment))
        ..add(MapEntry('returnAmount', returnAmount))
        ..add(MapEntry('upi_id', upiId));

      // Add images to form data with 'return_images[]' key
      for (File image in returnImages) {
        String filename = image.path.split("/").last;
        formData.files.add(MapEntry(
          'return_images[]', // Key for file upload
          await MultipartFile.fromFile(image.path, filename: filename),
        ));
      }

      // Print the contents of formData for debugging
      print('Fields:');
      formData.fields.forEach((entry) {
        print('${entry.key}: ${entry.value}');
      });

      print('Files:');
      for (var fileEntry in formData.files) {
        var file = fileEntry.value as MultipartFile;
        print('${fileEntry.key}: ${file.filename} (${file.length} bytes)');
      }

      // Send the POST request
      Response response = await _dio!.post(uri, data: formData);

      return OrderShipmentReturnResponse.fromJson(response.data);
    } catch (error) {
      print('Error: $error');
      return OrderShipmentReturnResponse.withError(_handleError(error));
    }
  }






  String _handleError(error) {
    String errorDescription = "";
    if (error is DioException) {
      // DioError dioError = error as DioError;
      if (error is DioExceptionType) {
        switch (error.type) {
          case DioExceptionType.connectionTimeout:
            errorDescription = "Connection timeout with API server";
            break;
          case DioExceptionType.sendTimeout:
            errorDescription = "Send timeout in connection with API server";
            break;
          case DioExceptionType.receiveTimeout:
            errorDescription = "Receive timeout in connection with API server";
            break;
          case DioExceptionType.badResponse:
            errorDescription =
                "Received invalid status code: ${error.response?.statusCode}";
            break;
          case DioExceptionType.cancel:
            errorDescription = "Request to API server was cancelled";
            break;
        }
      } else {
        errorDescription = "Unexpected Error Occurred";
      }
    } else {
      errorDescription = error.toString();
      print(error);
      print(error.stackTrace);
    }
    return errorDescription;
  }
}
