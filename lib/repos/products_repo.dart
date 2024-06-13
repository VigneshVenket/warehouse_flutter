import 'package:flutter_kundol/api/api_provider.dart';
import 'package:flutter_kundol/api/responses/product_detail_response.dart';
import 'package:flutter_kundol/api/responses/products_response.dart';

abstract class ProductsRepo {
  Future<ProductsResponse> fetchProducts(int pageNo);
  Future<ProductsResponse> fetchTopSellingProducts(int pageNo);
  Future<ProductsResponse> fetchSuperDealsProducts(int pageNo);
  Future<ProductsResponse> fetchFeaturedProducts(int pageNo,
      {String? variation,
      String? attributes,
      String? variation_name,
      String? priceTo,
      String? priceFrom});
  Future<ProductsResponse> fetchProductsByCat(
      int pageNo, String categoryId, String sortBy, String sortType,
      {String? variation,
      String? attributes,
      String? variation_name,
      String? priceTo,
      String? priceFrom});
  Future<ProductsResponse> fetchSearchProducts(String keyword, int pageNo,
      {String? variation,
      String? attributes,
      String? variation_name,
      String? priceTo,
      String? priceFrom});
  Future<ProductDetailResponse> fetchProductById(int productId);
  Future<ProductsResponse> fetchNewArrivalProduct(
      int pageNo, String categoryId);
}

class RealProductsRepo implements ProductsRepo {
  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<ProductsResponse> fetchProducts(int pageNo) {
    return _apiProvider.getProducts(pageNo);
  }

  @override
  Future<ProductsResponse> fetchProductsByCat(
      int pageNo, String categoryId, String sortBy, String sortType,
      {String? variation,
      String? attributes,
      String? variation_name,
      String? priceTo,
      String? priceFrom}) {
    return _apiProvider.getProductsByCat(pageNo, categoryId, sortBy, sortType,
        variation: variation ?? "",
        attributes: attributes ?? "",
        variation_name: variation_name ?? "",
        priceFrom: priceFrom ?? "",
        priceTo: priceTo ?? '');
  }

  @override
  Future<ProductsResponse> fetchSearchProducts(String keyword, int pageNo,
      {String? variation,
      String? attributes,
      String? variation_name,
      String? priceTo,
      String? priceFrom}) {
    return _apiProvider.getSearchProducts(keyword, pageNo,
        variation: variation ?? "",
        attributes: attributes ?? "",
        variation_name: variation_name ?? "",
        priceFrom: priceFrom ?? "",
        priceTo: priceTo ?? '');
  }

  @override
  Future<ProductDetailResponse> fetchProductById(int productId) {
    return _apiProvider.getProductById(productId.toString());
  }

  @override
  Future<ProductsResponse> fetchFeaturedProducts(int pageNo,
      {String? variation,
      String? attributes,
      String? variation_name,
      String? priceTo,
      String? priceFrom}) {
    return _apiProvider.getFeaturedProducts(pageNo,
        variation: variation ?? "",
        attributes: attributes ?? "",
        variation_name: variation_name ?? "",
        priceFrom: priceFrom ?? "",
        priceTo: priceTo ?? '');
  }

  @override
  Future<ProductsResponse> fetchSuperDealsProducts(int pageNo) {
    return _apiProvider.getDealsProducts(pageNo);
  }

  @override
  Future<ProductsResponse> fetchTopSellingProducts(int pageNo) {
    return _apiProvider.getTopSellingProducts(pageNo);
  }

  @override
  Future<ProductsResponse> fetchNewArrivalProduct(int pageNo, String cat) {
    return _apiProvider.getNewArrivalProducts(pageNo, cat);
  }
}

class FakeProductsRepo implements ProductsRepo {
  @override
  Future<ProductsResponse> fetchProducts(int pageNo) {
    throw UnimplementedError();
  }

  @override
  Future<ProductsResponse> fetchProductsByCat(
      int pageNo, String categoryId, String sortBy, String sortType,
      {String? variation,
      String? attributes,
      String? variation_name,
      String? priceTo,
      String? priceFrom}) {
    throw UnimplementedError();
  }

  @override
  Future<ProductsResponse> fetchSearchProducts(String keyword, int pageNo,
      {String? variation,
      String? attributes,
      String? variation_name,
      String? priceTo,
      String? priceFrom}) {
    throw UnimplementedError();
  }

  @override
  Future<ProductDetailResponse> fetchProductById(int productId) {
    throw UnimplementedError();
  }

  @override
  Future<ProductsResponse> fetchFeaturedProducts(pageNo,
      {String? variation,
      String? attributes,
      String? variation_name,
      String? priceTo,
      String? priceFrom}) {
    throw UnimplementedError();
  }

  @override
  Future<ProductsResponse> fetchSuperDealsProducts(int pageNo) {
    throw UnimplementedError();
  }

  @override
  Future<ProductsResponse> fetchTopSellingProducts(int pageNo) {
    throw UnimplementedError();
  }

  @override
  Future<ProductsResponse> fetchNewArrivalProduct(int pageNo, String cat) {
    throw UnimplementedError();
  }
}
