class CartData {
  String? session;
  var productId;
  String? productWeight;
  String? productType;
  var productCombinationId;
  List<ProductCombination>? productCombination;
  List<Combination>? combination;
  var qty;
 // int? cartTotalitems = 5;
  List<ProductDetail>? productDetail;
  ProductGallary? productGallary;
  Customer? customer;
  List<ParentCategoryDetail>? categoryDetail;
  var price;
  String? productPriceSymbol;
  var discountPrice;
  String? productDiscountPriceSymbol;
  var total;
  int? product_max_order;

  CartData(
      {this.session,
        this.productId,
        this.productWeight,
        this.productType,
        this.productCombinationId,
        this.productCombination,
        this.combination,
        this.qty,
        this.productDetail,
        this.productGallary,
        this.customer,
        this.categoryDetail,
        this.price,
        this.productPriceSymbol,
        this.discountPrice,
        this.productDiscountPriceSymbol,
        this.total,
        this.product_max_order
      });

  CartData.fromJson(Map<String, dynamic> json) {
    session = json['session'];
    productId = json['product_id'];
    productWeight=json['product_weight'];
    productType = json['product_type'];
    productCombinationId = json['product_combination_id'];
    if (json['product_combination'] != null) {
      productCombination = <ProductCombination>[];
      json['product_combination'].forEach((v) {
        productCombination?.add(ProductCombination.fromJson(v));
      });
    }
    if (json['combination'] != null) {
      combination = <Combination>[];
      json['combination'].forEach((v) {
        combination?.add(Combination.fromJson(v));
      });
    }
    qty = json['qty'];
    if (json['product_detail'] != null) {
      productDetail = <ProductDetail>[];
      json['product_detail'].forEach((v) {
        productDetail?.add(ProductDetail.fromJson(v));
      });
    }
    productGallary = json['product_gallary'] != null
        ? ProductGallary.fromJson(json['product_gallary'])
        : null;
    customer = json['customer'] != null
        ? Customer.fromJson(json['customer'])
        : null;
    if (json['category_detail'] != null) {
      categoryDetail = <ParentCategoryDetail>[];
      json['category_detail'].forEach((v) {
        categoryDetail?.add(ParentCategoryDetail.fromJson(v));
      });
    }
    price = json['price'];
    productPriceSymbol = json['product_price_symbol'];
    discountPrice = json['discount_price'];
    productDiscountPriceSymbol = json['product_discount_price_symbol'];
    total = json['total'];
    product_max_order=json['product_max_order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['session'] = session;
    data['product_id'] = productId;
    data['product_weight']=productWeight;
    data['product_type'] = productType;
    data['product_combination_id'] = productCombinationId;
    if (productCombination != null) {
      data['product_combination'] =
          productCombination?.map((v) => v.toJson()).toList();
    }
    if (combination != null) {
      data['combination'] = combination?.map((v) => v.toJson()).toList();
    }
    data['qty'] = qty;
    if (productDetail != null) {
      data['product_detail'] =
          productDetail?.map((v) => v.toJson()).toList();
    }
    if (productGallary != null) {
      data['product_gallary'] = productGallary?.toJson();
    }
    if (customer != null) {
      data['customer'] = customer?.toJson();
    }
    if (categoryDetail != null) {
      data['category_detail'] =
          categoryDetail?.map((v) => v.toJson()).toList();
    }
    data['price'] = price;
    data['product_price_symbol'] = productPriceSymbol;
    data['discount_price'] = discountPrice;
    data['product_discount_price_symbol'] = productDiscountPriceSymbol;
    data['total'] = total;
    return data;
  }
}

class ProductCombination {
  var variationId;
  Variation? variation;

  ProductCombination({this.variationId, this.variation});

  ProductCombination.fromJson(Map<String, dynamic> json) {
    variationId = json['variation_id'];
    variation = json['variation'] != null
        ? Variation.fromJson(json['variation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['variation_id'] = variationId;
    if (variation != null) {
      data['variation'] = variation?.toJson();
    }
    return data;
  }
}

class Variation {
  int? id;
  List<VariationDetail>? detail;

  Variation({this.id, this.detail});

  Variation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['detail'] != null) {
      detail = <VariationDetail>[];
      json['detail'].forEach((v) {
        detail?.add(VariationDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (detail != null) {
      data['detail'] = detail?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VariationDetail {
  String? name;
  Language? language;

  VariationDetail({this.name, this.language});

  VariationDetail.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    language = json['language'] != null
        ? Language.fromJson(json['language'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    if (language != null) {
      data['language'] = language?.toJson();
    }
    return data;
  }
}

class Language {
  int? id;
  String? languageName;
  String? code;
  var isDefault;
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

class Combination {
  int? productCombinationId;
  var productId;
  String? sku;
  var price;
  String? availableQty;
  Gallary? gallary;
  List<Combination>? combination;

  Combination(
      {this.productCombinationId,
        this.productId,
        this.sku,
        this.price,
        this.availableQty,
        this.gallary,
        this.combination});

  Combination.fromJson(Map<String, dynamic> json) {
    productCombinationId = json['product_combination_id'];
    productId = json['product_id'];
    sku = json['sku'];
    price = json['price'];
    availableQty = json['available_qty'];
    gallary =
    json['gallary'] != null ? Gallary.fromJson(json['gallary']) : null;
    if (json['combination'] != null) {
      combination = <Combination>[];
      json['combination'].forEach((v) {
        combination?.add(Combination.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_combination_id'] = productCombinationId;
    data['product_id'] = productId;
    data['sku'] = sku;
    data['price'] = price;
    data['available_qty'] = availableQty;
    if (gallary != null) {
      data['gallary'] = gallary?.toJson();
    }
    if (combination != null) {
      data['combination'] = combination?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Gallary {
  int? id;
  String? gallaryName;
  String? gallaryExtension;
  var userId;

  Gallary({this.id, this.gallaryName, this.gallaryExtension, this.userId});

  Gallary.fromJson(Map<String, dynamic> json) {
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

class ProductDetail {
  var productId;
  String? title;
  String? desc;
  Language? language;

  ProductDetail({this.productId, this.title, this.desc, this.language});

  ProductDetail.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    title = json['title'];
    desc = json['desc'];
    language = json['language'] != null
        ? Language.fromJson(json['language'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['title'] = title;
    data['desc'] = desc;
    if (language != null) {
      data['language'] = language?.toJson();
    }
    return data;
  }
}

class ProductGallary {
  int? id;
  String? gallaryName;
  String? gallaryExtension;
  var userId;
  List<GalleryDetail>? detail;

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
      detail = <GalleryDetail>[];
      json['detail'].forEach((v) {
        detail?.add(GalleryDetail.fromJson(v));
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

class GalleryDetail {
  int? id;
  String? gallaryType;
  var gallaryHeight;
  var gallaryWidth;
  String? gallaryPath;

  GalleryDetail(
      {this.id,
        this.gallaryType,
        this.gallaryHeight,
        this.gallaryWidth,
        this.gallaryPath});

  GalleryDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gallaryType = json['gallary_type'];
    gallaryHeight = json['gallary_height'];
    gallaryWidth = json['gallary_width'];
    gallaryPath = json['gallary_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['gallary_type'] = gallaryType;
    data['gallary_height'] = gallaryHeight;
    data['gallary_width'] = gallaryWidth;
    data['gallary_path'] = gallaryPath;
    return data;
  }
}

class Customer {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? isSeen;
  String? status;
  String? hash;
  String? createdAt;
  String? updatedAt;

  Customer(
      {this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.isSeen,
        this.status,
        this.hash,
        this.createdAt,
        this.updatedAt});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    isSeen = json['is_seen'];
    status = json['status'];
    hash = json['hash'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['is_seen'] = isSeen;
    data['status'] = status;
    data['hash'] = hash;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class ParentCategoryDetail {
  var productId;
  ChildCategoryDetail? categoryDetail;

  ParentCategoryDetail({this.productId, this.categoryDetail});

  ParentCategoryDetail.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    categoryDetail = json['category_detail'] != null
        ? ChildCategoryDetail.fromJson(json['category_detail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    if (categoryDetail != null) {
      data['category_detail'] = categoryDetail?.toJson();
    }
    return data;
  }
}

class ChildCategoryDetail {
  int? id;
  int? parentId;
  String? slug;
  String? sortOrder;
  List<CategoryDetail>? detail;
  String? parentName;

  ChildCategoryDetail(
      {this.id,
        this.parentId,
        this.slug,
        this.sortOrder,
        this.detail,
        this.parentName});

  ChildCategoryDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    slug = json['slug'];
    sortOrder = json['sort_order'];
    if (json['detail'] != null) {
      detail = <CategoryDetail>[];
      json['detail'].forEach((v) {
        detail?.add(CategoryDetail.fromJson(v));
      });
    }
    parentName = json['parent_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['parent_id'] = parentId;
    data['slug'] = slug;
    data['sort_order'] = sortOrder;
    if (detail != null) {
      data['detail'] = detail?.map((v) => v.toJson()).toList();
    }
    data['parent_name'] = parentName;
    return data;
  }
}

class CategoryDetail {
  var categoryId;
  String? name;
  String? description;
  Language? language;

  CategoryDetail({this.categoryId, this.name, this.description, this.language});

  CategoryDetail.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    name = json['name'];
    description = json['description'];
    language = json['language'] != null
        ? Language.fromJson(json['language'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category_id'] = categoryId;
    data['name'] = name;
    data['description'] = description;
    if (language != null) {
      data['language'] = language?.toJson();
    }
    return data;
  }
}