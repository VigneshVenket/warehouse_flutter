class GetWishlistOnStartData {
  int? wishlist;
  var productId;
  var customerId;

  GetWishlistOnStartData({this.wishlist, this.productId, this.customerId});

  GetWishlistOnStartData.fromJson(Map<String, dynamic> json) {
    wishlist = json['wishlist'];
    productId = json['product_id'];
    customerId = json['customer_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wishlist'] = wishlist;
    data['product_id'] = productId;
    data['customer_id'] = customerId;
    return data;
  }
}