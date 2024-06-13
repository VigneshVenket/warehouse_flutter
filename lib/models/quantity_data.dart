class QuantityData {
  var productId;
  var productCombinationId;
  String? productType;
  var warehouseId;
  String? stockIn;
  String? stockOut;
  var remainingStock;
  var price;
  var discountPrice;

  QuantityData(
      {this.productId,
        this.productCombinationId,
        this.productType,
        this.warehouseId,
        this.stockIn,
        this.stockOut,
        this.remainingStock,
        this.price,
        this.discountPrice});

  QuantityData.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productCombinationId = json['product_combination_id'];
    productType = json['product_type'];
    warehouseId = json['warehouse_id'];
    stockIn = json['stock_in'];
    stockOut = json['stock_out'];
    remainingStock = json['remaining_stock'];
    price = json['price'];
    discountPrice = json['discount_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['product_combination_id'] = productCombinationId;
    data['product_type'] = productType;
    data['warehouse_id'] = warehouseId;
    data['stock_in'] = stockIn;
    data['stock_out'] = stockOut;
    data['remaining_stock'] = remainingStock;
    data['price'] = price;
    data['discount_price'] = discountPrice;
    return data;
  }
}