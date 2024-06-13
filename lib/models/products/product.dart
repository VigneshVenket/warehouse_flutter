import 'package:flutter_kundol/models/filters_data.dart';

class Product {
  int? productId;
  String? productType;
  String? productSlug;
  String? productVideoUrl;
  ProductGallary? productGallary;
  List<ProductGallary>? productGallaryDetail;
  var productPrice;
  var productDiscountPrice;
  ProductUnit? productUnit;
  String? productWeight;
  String? productStatus;
  ProductBrand? productBrand;
  String? productView;
  var isFeatured;
  String? isPoints;
  var productMinOrder;
  var productMaxOrder;
  String? seoMetaTag;
  String? seoDesc;
  double? productRating;
  List<ProductCategory>? category;
  List<ProductDetail>? detail;
  List<ProductAttribute>? attribute;
  List<ProductCombination>? productCombination;
  List<Reviews>? reviews;
  ProductsStock? stock;

  Product(
      {this.productId,
      this.productType,
      this.productSlug,
      this.productVideoUrl,
      this.productGallary,
      this.productGallaryDetail,
      this.productPrice,
      this.productDiscountPrice,
      this.productUnit,
      this.productWeight,
      this.productStatus,
      this.productBrand,
      this.productView,
      this.isFeatured,
      this.isPoints,
      this.productMinOrder,
      this.productMaxOrder,
      this.seoMetaTag,
      this.seoDesc,
      this.productRating,
      this.category,
      this.detail,
      this.attribute,
      this.productCombination,
      this.reviews,
      this.stock});

  Product.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productType = json['product_type'];
    productSlug = json['product_slug'];
    productVideoUrl = json['product_video_url'];
    productGallary = json['product_gallary'] != null
        ? ProductGallary.fromJson(json['product_gallary'])
        : null;
    if (json['product_gallary_detail'] != null) {
      productGallaryDetail = [];
      json['product_gallary_detail'].forEach((v) {
        productGallaryDetail?.add(ProductGallary.fromJson(v));
      });
    }
    productPrice = json['product_price'];
    productDiscountPrice = json['product_discount_price'];
    productUnit = json['product_unit'] != null
        ? ProductUnit.fromJson(json['product_unit'])
        : null;
    productWeight = json['product_weight'];
    productStatus = json['product_status'];
    productBrand = json['product_brand'] != null
        ? ProductBrand.fromJson(json['product_brand'])
        : null;
    productView = json['product_view'];
    isFeatured = json['is_featured'];
    isPoints = json['is_points'];
    productMinOrder = json['product_min_order'];
    productMaxOrder = json['product_max_order'];
    seoMetaTag = json['seo_meta_tag'];
    seoDesc = json['seo_desc'];
    productRating = json['product_rating']?.toDouble();
    if (json['category'] != null) {
      category = [];
      json['category'].forEach((v) {
        category?.add(ProductCategory.fromJson(v));
      });
    }
    if (json['detail'] != null) {
      detail = [];
      json['detail'].forEach((v) {
        detail?.add(ProductDetail.fromJson(v));
      });
    }
    if (json['attribute'] != null) {
      attribute = [];
      json['attribute'].forEach((v) {
        attribute?.add(ProductAttribute.fromJson(v));
      });
    }
    if (json['product_combination'] != null) {
      productCombination = [];
      json['product_combination'].forEach((v) {
        productCombination?.add(ProductCombination.fromJson(v));
      });
    }
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews?.add(Reviews.fromJson(v));
      });
    }
    stock = json['stock'] != null
        ? ProductsStock.fromJson(json['stock'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['product_type'] = productType;
    data['product_slug'] = productSlug;
    data['product_video_url'] = productVideoUrl;
    if (productGallary != null) {
      data['product_gallary'] = productGallary?.toJson();
    }
    if (productGallaryDetail != null) {
      data['product_gallary_detail'] =
          productGallaryDetail?.map((v) => v.toJson()).toList();
    }
    data['product_price'] = productPrice;
    data['product_discount_price'] = productDiscountPrice;
    if (productUnit != null) {
      data['product_unit'] = productUnit?.toJson();
    }
    data['product_weight'] = productWeight;
    data['product_status'] = productStatus;
    if (productBrand != null) {
      data['product_brand'] = productBrand?.toJson();
    }
    data['product_view'] = productView;
    data['is_featured'] = isFeatured;
    data['is_points'] = isPoints;
    data['product_min_order'] = productMinOrder;
    data['product_max_order'] = productMaxOrder;
    data['seo_meta_tag'] = seoMetaTag;
    data['seo_desc'] = seoDesc;
    data['product_rating'] = productRating;
    if (category != null) {
      data['category'] = category?.map((v) => v.toJson()).toList();
    }
    if (detail != null) {
      data['detail'] = detail?.map((v) => v.toJson()).toList();
    }
    if (attribute != null) {
      data['attribute'] = attribute?.map((v) => v.toJson()).toList();
    }
    if (productCombination != null) {
      data['product_combination'] =
          productCombination?.map((v) => v.toJson()).toList();
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

class ProductGallary {
  int? id;
  String? gallaryName;
  List<PGDetail>? detail;

  ProductGallary({this.id, this.gallaryName, this.detail});

  ProductGallary.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gallaryName = json['gallary_name'];
    if (json['detail'] != null) {
      detail = [];
      json['detail'].forEach((v) {
        detail?.add(PGDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['gallary_name'] = gallaryName;
    if (detail != null) {
      data['detail'] = detail?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PGDetail {
  int? id;
  String? gallaryType;
  String? gallaryPath;

  PGDetail({this.id, this.gallaryType, this.gallaryPath});

  PGDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gallaryType = json['gallary_type'];
    gallaryPath = json['gallary_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['gallary_type'] = gallaryType;
    data['gallary_path'] = gallaryPath;
    return data;
  }
}

class ProductUnit {
  int? id;
  var isActive;

  ProductUnit({this.id, this.isActive});

  ProductUnit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['is_active'] = isActive;
    return data;
  }
}

class ProductBrand {
  int? brandId;
  String? brandName;
  String? brandSlug;
  ProductBrandGallary? gallary;
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
    gallary = json['gallary'] != null
        ? ProductBrandGallary.fromJson(json['gallary'])
        : null;
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

class ProductBrandGallary {
  int? id;
  String? name;
  String? extension;
  var userId;
  var createdBy;
  String? updatedBy;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  ProductBrandGallary(
      {this.id,
      this.name,
      this.extension,
      this.userId,
      this.createdBy,
      this.updatedBy,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});

  ProductBrandGallary.fromJson(Map<String, dynamic> json) {
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

class ProductCategory {
  var productId;
  CategoryDetail? categoryDetail;

  ProductCategory({this.productId, this.categoryDetail});

  ProductCategory.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    categoryDetail = json['category_detail'] != null
        ? CategoryDetail.fromJson(json['category_detail'])
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

class CategoryDetail {
  int? id;
  int? parentId;
  String? slug;
  String? sortOrder;
  List<CategoryDetailDetail>? detail;

  CategoryDetail(
      {this.id, this.parentId, this.slug, this.sortOrder, this.detail});

  CategoryDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    slug = json['slug'];
    sortOrder = json['sort_order'];
    if (json['detail'] != null) {
      detail = [];
      json['detail'].forEach((v) {
        detail?.add(CategoryDetailDetail.fromJson(v));
      });
    }
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
    return data;
  }
}

class CategoryDetailDetail {
  var categoryId;
  String? name;
  String? description;
  Language? language;

  CategoryDetailDetail(
      {this.categoryId, this.name, this.description, this.language});

  CategoryDetailDetail.fromJson(Map<String, dynamic> json) {
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

class ProductAttribute {
  String? productId;
  Attributes? attributes;
  List<ProductAttributeVariations>? variations;

  ProductAttribute({this.productId, this.attributes, this.variations});

  ProductAttribute.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'].toString();
    attributes = json['attributes'] != null
        ? Attributes.fromJson(json['attributes'])
        : null;
    if (json['variations'] != null) {
      variations = [];
      json['variations'].forEach((v) {
        variations?.add(ProductAttributeVariations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    if (attributes != null) {
      data['attributes'] = attributes?.toJson();
    }
    if (variations != null) {
      data['variations'] = variations?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Attributes {
  int? attributeId;
  List<AttributeDetail>? detail;

  Attributes({this.attributeId, this.detail});

  Attributes.fromJson(Map<String, dynamic> json) {
    attributeId = json['attribute_id'];
    if (json['detail'] != null) {
      detail = [];
      json['detail'].forEach((v) {
        detail?.add(AttributeDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['attribute_id'] = attributeId;
    if (detail != null) {
      data['detail'] = detail?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AttributeDetail {
  String? name;

  AttributeDetail({this.name});

  AttributeDetail.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}

class ProductAttributeVariations {
  ProductVariation? productVariation;

  ProductAttributeVariations({this.productVariation});

  ProductAttributeVariations.fromJson(Map<String, dynamic> json) {
    productVariation = json['product_variation'] != null
        ? ProductVariation.fromJson(json['product_variation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (productVariation != null) {
      data['product_variation'] = productVariation?.toJson();
    }
    return data;
  }
}

class ProductVariation {
  int? id;
  List<Detail>? detail;

  ProductVariation({this.id, this.detail});

  ProductVariation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['detail'] != null) {
      detail = [];
      json['detail'].forEach((v) {
        detail?.add(Detail.fromJson(v));
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

class Detail {
  String? name;
  Language? language;

  Detail({this.name, this.language});

  Detail.fromJson(Map<String, dynamic> json) {
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

class ProductCombination {
  var productCombinationId;
  int? productId;
  int? price;
  ProductCombinationGallary? gallary;
  List<Combination>? combination;

  ProductCombination(
      {this.productCombinationId,
      this.productId,
      this.price,
      this.gallary,
      this.combination});

  ProductCombination.fromJson(Map<String, dynamic> json) {
    productCombinationId = json['product_combination_id'];
    productId = json['product_id'];
    price = json['price'];
    gallary = json['gallary'] != null
        ? ProductCombinationGallary.fromJson(json['gallary'])
        : null;
        print("Combination.fromJson(v)");
        print(json);
    if (json['combination'] != null) {
      combination = [];
      json['combination'].forEach((v) {
        combination?.add(Combination.fromJson(v));
        
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_combination_id'] = productCombinationId;
    data['product_id'] = productId;
    data['price'] = price;
    if (gallary != null) {
      data['gallary'] = gallary?.toJson();
    }
    if (combination != null) {
      data['combination'] = combination?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductCombinationGallary {
  int? id;
  String? gallaryName;

  ProductCombinationGallary({this.id, this.gallaryName});

  ProductCombinationGallary.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gallaryName = json['gallary_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['gallary_name'] = gallaryName;
    return data;
  }
}

class Combination {
  var variationId;
  ProductVariation? variation;

  Combination({this.variationId, this.variation});

  Combination.fromJson(Map<String, dynamic> json) {
    variationId = json['variation_id'];
    variation = json['variation'] != null
        ? ProductVariation.fromJson(json['variation'])
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

class ProductsStock {
  int? productId;
  var productCombinationId;
  String? productType;
  int? warehouseId;
  String? stockIn;
  String? stockOut;
  String? remainingStock;
  var price;
  var discountPrice;

  ProductsStock(
      {this.productId,
      this.productCombinationId,
      this.productType,
      this.warehouseId,
      this.stockIn,
      this.stockOut,
      this.remainingStock,
      this.price,
      this.discountPrice});

  ProductsStock.fromJson(Map<String, dynamic> json) {
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
