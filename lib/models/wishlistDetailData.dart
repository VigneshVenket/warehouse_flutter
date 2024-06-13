import 'package:flutter_kundol/models/products/product.dart';

class WishlistDetailData {
  int? wishlist;
  Product? products;
  var productId;
  var customerId;

  WishlistDetailData({this.wishlist, this.products, this.productId, this.customerId});

  WishlistDetailData.fromJson(Map<String, dynamic> json) {
    wishlist = json['wishlist'];
    products = json['products'] != null
        ? Product.fromJson(json['products'])
        : null;
    productId = json['product_id'];
    customerId = json['customer_id'];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wishlist'] = wishlist;
    if (products != null) {
      data['products'] = products?.toJson();
    }
    data['product_id'] = productId;
    data['customer_id'] = customerId;
    return data;
  }
}
