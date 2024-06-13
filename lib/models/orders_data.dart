class OrdersData {
  int? orderId;
  String? billingFirstName;
  String? billingLastName;
  String? billingCompany;
  String? billingStreetAadress;
  String? billingSuburb;
  String? billingCity;
  String? billingPostcode;
  String? billingPhone;
  String? deliveryFirstName;
  String? deliveryLastName;
  String? deliveryCompany;
  String? deliveryStreetAadress;
  String? deliverySuburb;
  String? deliveryCity;
  String? deliveryPostcode;
  String? deliveryPhone;
  String? ccType;
  String? ccOwner;
  String? ccNumber;
  String? ccExpiry;
  var currencyValue;
  var orderPrice;
  var shippingCost;
  String? shippingMethod;
  String? shippingDuration;
  var isSeen;
  String? couponCode;
  var couponAmount;
  String? paymentMethod;
  String? transactionId;
  String? orderStatus;
  var totalTax;
  String? orderDate;
  List<OrderDetail>? orderDetail;
  String? waybill;
  String? gstNumber;
  num? gstDiscount;

  OrdersData(
      {this.orderId,
        this.billingFirstName,
        this.billingLastName,
        this.billingCompany,
        this.billingStreetAadress,
        this.billingSuburb,
        this.billingCity,
        this.billingPostcode,
        this.billingPhone,
        this.deliveryFirstName,
        this.deliveryLastName,
        this.deliveryCompany,
        this.deliveryStreetAadress,
        this.deliverySuburb,
        this.deliveryCity,
        this.deliveryPostcode,
        this.deliveryPhone,
        this.ccType,
        this.ccOwner,
        this.ccNumber,
        this.ccExpiry,
        this.currencyValue,
        this.orderPrice,
        this.shippingCost,
        this.shippingMethod,
        this.shippingDuration,
        this.isSeen,
        this.couponCode,
        this.couponAmount,
        this.paymentMethod,
        this.transactionId,
        this.orderStatus,
        this.totalTax,
        this.orderDate,
        this.orderDetail,
        this.waybill,
        this.gstNumber,
        this.gstDiscount
      });

  OrdersData.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    billingFirstName = json['billing_first_name'];
    billingLastName = json['billing_last_name'];
    billingCompany = json['billing_company'];
    billingStreetAadress = json['billing_street_aadress'];
    billingSuburb = json['billing_suburb'];
    billingCity = json['billing_city'];
    billingPostcode = json['billing_postcode'];
    billingPhone = json['billing_phone'];
    deliveryFirstName = json['delivery_first_name'];
    deliveryLastName = json['delivery_last_name'];
    deliveryCompany = json['delivery_company'];
    deliveryStreetAadress = json['delivery_street_aadress'];
    deliverySuburb = json['delivery_suburb'];
    deliveryCity = json['delivery_city'];
    deliveryPostcode = json['delivery_postcode'];
    deliveryPhone = json['delivery_phone'];
    ccType = json['cc_type'];
    ccOwner = json['cc_owner'];
    ccNumber = json['cc_number'];
    ccExpiry = json['cc_expiry'];
    currencyValue = json['currency_value'];
    orderPrice = json['order_price'];
    shippingCost = json['shipping_cost'];
    shippingMethod = json['shipping_method'];
    shippingDuration = json['shipping_duration'];
    isSeen = json['is_seen'];
    couponCode = json['coupon_code'];
    couponAmount = json['coupon_amount'];
    paymentMethod = json['payment_method'];
    transactionId = json['transaction_id'];
    orderStatus = json['order_status'];
    totalTax = json['total_tax'];
    orderDate = json['order_date'];
    waybill=json['waybill'];
    if (json['order_detail'] != null) {
      orderDetail = <OrderDetail>[];
      json['order_detail'].forEach((v) {
        orderDetail?.add(OrderDetail.fromJson(v));
      });
    }
    gstNumber=json['gst_no'];
    gstDiscount=json['gst_discount'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['billing_first_name'] = billingFirstName;
    data['billing_last_name'] = billingLastName;
    data['billing_company'] = billingCompany;
    data['billing_street_aadress'] = billingStreetAadress;
    data['billing_suburb'] = billingSuburb;
    data['billing_city'] = billingCity;
    data['billing_postcode'] = billingPostcode;
    data['billing_phone'] = billingPhone;
    data['delivery_first_name'] = deliveryFirstName;
    data['delivery_last_name'] = deliveryLastName;
    data['delivery_company'] = deliveryCompany;
    data['delivery_street_aadress'] = deliveryStreetAadress;
    data['delivery_suburb'] = deliverySuburb;
    data['delivery_city'] = deliveryCity;
    data['delivery_postcode'] = deliveryPostcode;
    data['delivery_phone'] = deliveryPhone;
    data['cc_type'] = ccType;
    data['cc_owner'] = ccOwner;
    data['cc_number'] = ccNumber;
    data['cc_expiry'] = ccExpiry;
    data['currency_value'] = currencyValue;
    data['order_price'] = orderPrice;
    data['shipping_cost'] = shippingCost;
    data['shipping_method'] = shippingMethod;
    data['shipping_duration'] = shippingDuration;
    data['is_seen'] = isSeen;
    data['coupon_code'] = couponCode;
    data['coupon_amount'] = couponAmount;
    data['payment_method'] = paymentMethod;
    data['transaction_id'] = transactionId;
    data['order_status'] = orderStatus;
    data['total_tax'] = totalTax;
    data['order_date'] = orderDate;
    data['waybill']=waybill;
    if (orderDetail != null) {
      data['order_detail'] = orderDetail?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class OrderDetail {
  Product? product;
  var productPrice;
  var productDiscount;
  var productTax;
  var productQty;
  var productTotal;

  OrderDetail(        
      {this.product,
        this.productPrice,
        this.productDiscount,
        this.productTax,
        this.productQty,
        this.productTotal});

  OrderDetail.fromJson(Map<String, dynamic> json) {
    product =
    json['product'] != null ? Product.fromJson(json['product']) : null;
    productPrice = json['product_price'];
    productDiscount = json['product_discount'];
    productTax = json['product_tax'];
    productQty = json['product_qty'];
    productTotal = json['product_total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (product != null) {
      data['product'] = product?.toJson();
    }
    data['product_price'] = productPrice;
    data['product_discount'] = productDiscount;
    data['product_tax'] = productTax;
    data['product_qty'] = productQty;
    data['product_total'] = productTotal;
    return data;
  }
}

class Product {
  int? productId;
  String? productType;
  String? productSlug;
  ProductGallary? productGallary;
  List<ProductGallaryDetail>? productGallaryDetail;
  var productPrice;
  var productDiscountPrice;
  String? productStatus;
  ProductBrand? productBrand;
  var isFeatured;
  String? isPoints;
  List<Detail>? detail;
  List<Reviews>? reviews;
  Stock? stock;

  Product(
      {this.productId,
        this.productType,
        this.productSlug,
        this.productGallary,
        this.productGallaryDetail,
        this.productPrice,
        this.productDiscountPrice,
        this.productStatus,
        this.productBrand,
        this.isFeatured,
        this.isPoints,
        this.detail,
        this.reviews,
        this.stock});

  Product.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productType = json['product_type'];
    productSlug = json['product_slug'];
    productGallary = json['product_gallary'] != null
        ? ProductGallary.fromJson(json['product_gallary'])
        : null;
    if (json['product_gallary_detail'] != null) {
      productGallaryDetail = <ProductGallaryDetail>[];
      json['product_gallary_detail'].forEach((v) {
        productGallaryDetail?.add(ProductGallaryDetail.fromJson(v));
      });
    }
    productPrice = json['product_price'];
    productDiscountPrice = json['product_discount_price'];
    productStatus = json['product_status'];
    productBrand = json['product_brand'] != null
        ? ProductBrand.fromJson(json['product_brand'])
        : null;
    isFeatured = json['is_featured'];
    isPoints = json['is_points'];
    if (json['detail'] != null) {
      detail = <Detail>[];
      json['detail'].forEach((v) {
        detail?.add(Detail.fromJson(v));
      });
    }
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews?.add(Reviews.fromJson(v));
      });
    }
    stock = json['stock'] != null ? Stock.fromJson(json['stock']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['product_type'] = productType;
    data['product_slug'] = productSlug;
    if (productGallary != null) {
      data['product_gallary'] = productGallary?.toJson();
    }
    if (productGallaryDetail != null) {
      data['product_gallary_detail'] =
          productGallaryDetail?.map((v) => v.toJson()).toList();
    }
    data['product_price'] = productPrice;
    data['product_discount_price'] = productDiscountPrice;
    data['product_status'] = productStatus;
    if (productBrand != null) {
      data['product_brand'] = productBrand?.toJson();
    }
    data['is_featured'] = isFeatured;
    data['is_points'] = isPoints;
    if (detail != null) {
      data['detail'] = detail?.map((v) => v.toJson()).toList();
    }
    if (reviews != null) {
      data['reviews'] = reviews?.map((v) => v.toJson()).toList();
    }
    if (stock != null) {
      data['stock'] = stock?.toJson();
    }
    return data;
  }
}

class ProductGallary {
  int? id;
  String? gallaryName;
  String? gallaryExtension;
  var userId;
  List<Detail>? detail;

  ProductGallary(
      {this.id,
        this.gallaryName,
        this.gallaryExtension,
        this.userId,
        this.detail});

  ProductGallary.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gallaryName = json['gallary_name'];
    gallaryExtension = json['gallary_extension'];
    userId = json['user_id'];
    if (json['detail'] != null) {
      detail = <Detail>[];
      json['detail'].forEach((v) {
        detail?.add(Detail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['gallary_name'] = gallaryName;
    data['gallary_extension'] = gallaryExtension;
    data['user_id'] = userId;
    if (detail != null) {
      data['detail'] = detail?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Detail {
  int? id;
  String? title;
  String? desc;
  // var gallaryWidth;
  // String? gallaryPath;

  Detail(
      {this.id,
       this.title,
        this.desc
        // this.gallaryWidth,
        // this.gallaryPath
      });

  Detail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    desc = json['desc'];
    // gallaryWidth = json['gallary_width'];
    // gallaryPath = json['gallary_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['desc'] = desc;
    // data['gallary_width'] = gallaryWidth;
    // data['gallary_path'] = gallaryPath;
    return data;
  }
}

class ProductGallaryDetail {
  int? id;
  String? gallaryName;
  String? gallaryExtension;
  var userId;

  ProductGallaryDetail(
      {this.id, this.gallaryName, this.gallaryExtension, this.userId});

  ProductGallaryDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gallaryName = json['gallary_name'];
    gallaryExtension = json['gallary_extension'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['gallary_name'] = gallaryName;
    data['gallary_extension'] = gallaryExtension;
    data['user_id'] = userId;
    return data;
  }
}

class ProductBrand {
  int? brandId;
  String? brandName;
  String? brandSlug;
  Gallary? gallary;
  String? brandStatus;

  ProductBrand(
      {this.brandId,
        this.brandName,
        this.brandSlug,
        this.gallary,
        this.brandStatus});

  ProductBrand.fromJson(Map<String, dynamic> json) {
    brandId = json['brand_id'];
    brandName = json['brand_name'];
    brandSlug = json['brand_slug'];
    gallary =
    json['gallary'] != null ? Gallary.fromJson(json['gallary']) : null;
    brandStatus = json['brand_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['brand_id'] = brandId;
    data['brand_name'] = brandName;
    data['brand_slug'] = brandSlug;
    if (gallary != null) {
      data['gallary'] = gallary?.toJson();
    }
    data['brand_status'] = brandStatus;
    return data;
  }
}

class Gallary {
  int? id;
  String? name;
  String? extension;
  var userId;
  var createdBy;
  var updatedBy;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  Gallary(
      {this.id,
        this.name,
        this.extension,
        this.userId,
        this.createdBy,
        this.updatedBy,
        this.deletedAt,
        this.createdAt,
        this.updatedAt});

  Gallary.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    extension = json['extension'];
    userId = json['user_id'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['extension'] = extension;
    data['user_id'] = userId;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Language {
  int? id;
  String? languageName;
  String? code;
  int? isDefault;
  String? direction;
  String? directory;

  Language(
      {this.id,
        this.languageName,
        this.code,
        this.isDefault,
        this.direction,
        this.directory});

  Language.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    languageName = json['language_name'];
    code = json['code'];
    isDefault = json['is_default'];
    direction = json['direction'];
    directory = json['directory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['language_name'] = languageName;
    data['code'] = code;
    data['is_default'] = isDefault;
    data['direction'] = direction;
    data['directory'] = directory;
    return data;
  }
}

class Reviews {
  int? id;
  String? comment;
  String? rating;
  String? status;

  Reviews({this.id, this.comment, this.rating, this.status});

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'];
    rating = json['rating'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['comment'] = comment;
    data['rating'] = rating;
    data['status'] = status;
    return data;
  }
}

class Stock {
  int? productId;
  String? productCombinationId;
  String? productType;
  int? warehouseId;
  String? stockIn;
  String? stockOut;
  String? remainingStock;
  var price;
  var discountPrice;

  Stock(
      {this.productId,
        this.productCombinationId,
        this.productType,
        this.warehouseId,
        this.stockIn,
        this.stockOut,
        this.remainingStock,
        this.price,
        this.discountPrice});

  Stock.fromJson(Map<String, dynamic> json) {
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

