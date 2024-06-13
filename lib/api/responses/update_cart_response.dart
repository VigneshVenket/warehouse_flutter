


import '../../constants/app_cart.dart';
import '../../constants/app_constants.dart';

class UpdateCartResponse {
   Data ?data;
   String? status;
   String ?message;
   int ?statusCode;

  UpdateCartResponse({
    required this.data,
    required this.status,
    required this.message,
    required this.statusCode,
  });

    UpdateCartResponse.fromJson(Map<String, dynamic> json) {

      data= Data.fromJson(json['data']);
      var s1 = AppBadge();
      s1.BadgeUpdate(int.parse(data!.qty));
      status= json['status'];
      message= json['message'];
      statusCode= json['status_code'];

  }

  UpdateCartResponse.withError(String error){
    status = AppConstants.STATUS_ERROR;
    message = error;
    statusCode = 0;
  }

}

class Data {
  final String session;
  final String productId;
  final String productWeight;
  final String productType;
  final dynamic productCombinationId;
  final List<dynamic> productCombination;
  final String qty;
  final List<ProductDetail> productDetail;
  final ProductGallary productGallary;
  final Customer customer;
  final List<CategoryDetailElement> categoryDetail;
  final int price;
  final String productPriceSymbol;
  final int discountPrice;
  final String productDiscountPriceSymbol;
  final int total;
  // final List<dynamic> currency;
  final int product_max_order;

  Data({
    required this.session,
    required this.productId,
    required this.productWeight,
    required this.productType,
    required this.productCombinationId,
    required this.productCombination,
    required this.qty,
    required this.productDetail,
    required this.productGallary,
    required this.customer,
    required this.categoryDetail,
    required this.price,
    required this.productPriceSymbol,
    required this.discountPrice,
    required this.productDiscountPriceSymbol,
    required this.total,
    required this.product_max_order
    // required this.currency,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    print(json.toString()); // Add this line to print the JSON string
    return Data(
      session: json['session'],
      productId: json['product_id'],
      productWeight: json['product_weight'],
      productType: json['product_type'],
      productCombinationId: json['product_combination_id'],
      // Check if product_combination is iterable
      productCombination: json['product_combination'] != null
          ? List<dynamic>.from(json['product_combination'])
          : [],
      qty: json['qty'],
      // Check if product_detail is iterable
      productDetail: json['product_detail'] != null
          ? List<ProductDetail>.from(json['product_detail'].map((x) => ProductDetail.fromJson(x)))
          : [],
      productGallary: ProductGallary.fromJson(json['product_gallary']),
      customer: Customer.fromJson(json['customer']),
      // Check if category_detail is iterable
      categoryDetail: json['category_detail'] != null
          ? List<CategoryDetailElement>.from(json['category_detail'].map((x) => CategoryDetailElement.fromJson(x)))
          : [],
      price: json['price'],
      productPriceSymbol: json['product_price_symbol'],
      discountPrice: json['discount_price'],
      productDiscountPriceSymbol: json['product_discount_price_symbol'],
      total: json['total'],
      product_max_order:json['product_max_order']
      // Check if currency is iterable
      // currency: json['currency'] != null
      //     ? List<dynamic>.from(json['currency'])
      //     : [],
    );
  }




}

class CategoryDetailElement {
  final int productId;
  final CategoryDetailCategoryDetail categoryDetail;

  CategoryDetailElement({
    required this.productId,
    required this.categoryDetail,
  });

  factory CategoryDetailElement.fromJson(Map<String, dynamic> json) {
    return CategoryDetailElement(
      productId: json['product_id'],
      categoryDetail: CategoryDetailCategoryDetail.fromJson(json['category_detail'] ?? {}),
    );
  }



}

class CategoryDetailCategoryDetail {
  final int id;
  final dynamic parentId;
  final String slug;
  final dynamic sortOrder;
  final String parentName;

  CategoryDetailCategoryDetail({
    required this.id,
    required this.parentId,
    required this.slug,
    required this.sortOrder,
    required this.parentName,
  });

  factory CategoryDetailCategoryDetail.fromJson(Map<String, dynamic> json) {
    return CategoryDetailCategoryDetail(
      id: json['id'],
      parentId: json['parent_id'],
      slug: json['slug'],
      sortOrder: json['sort_order'],
      parentName: json['parent_name'],
    );
  }



}

class Customer {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  // final int gallaryId;
  final String isSeen;
  final String status;
  final dynamic provider;
  final dynamic providerId;
  final String hash;
  final dynamic forgetHash;
  // final int createdBy;
  final dynamic updatedBy;
  final dynamic deletedAt;
  final dynamic rememberToken;
  final DateTime createdAt;
  final DateTime updatedAt;

  Customer({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    // required this.gallaryId,
    required this.isSeen,
    required this.status,
    required this.provider,
    required this.providerId,
    required this.hash,
    required this.forgetHash,
    // required this.createdBy,
    required this.updatedBy,
    required this.deletedAt,
    required this.rememberToken,
    required this.createdAt,
    required this.updatedAt,
  });
  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      // gallaryId: json['gallary_id'],
      isSeen: json['is_seen'],
      status: json['status'],
      provider: json['provider'],
      providerId: json['provider_id'],
      hash: json['hash']?? '',
      forgetHash: json['forget_hash'],
      // createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      deletedAt: json['deleted_at'],
      rememberToken: json['remember_token'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }


}

class ProductDetail {
  final int productId;
  final String title;
  final String desc;
  final Language language;

  ProductDetail({
    required this.productId,
    required this.title,
    required this.desc,
    required this.language,
  });

  factory ProductDetail.fromJson(Map<String, dynamic> json) {
    return ProductDetail(
      productId: json['product_id'],
      title: json['title'],
      desc: json['desc'],
      language: Language.fromJson(json['language']),
    );
  }


}

class Language {
  final int id;
  final String languageName;
  final String code;
  final int isDefault;
  final String direction;
  final dynamic directory;
  final String status;

  Language({
    required this.id,
    required this.languageName,
    required this.code,
    required this.isDefault,
    required this.direction,
    required this.directory,
    required this.status,
  });


  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      id: json['id'],
      languageName: json['language_name'],
      code: json['code'],
      isDefault: json['is_default'],
      direction: json['direction'],
      directory: json['directory'],
      status: json['status'],
    );
  }


}

class ProductGallary {
  final int id;
  final String gallaryName;
  final String gallaryExtension;
  final int userId;
  final List<Detail> detail;

  ProductGallary({
    required this.id,
    required this.gallaryName,
    required this.gallaryExtension,
    required this.userId,
    required this.detail,
  });

  factory ProductGallary.fromJson(Map<String, dynamic> json) {
    return ProductGallary(
      id: json['id'],
      gallaryName: json['gallary_name'],
      gallaryExtension: json['gallary_extension'],
      userId: json['user_id'],
      detail: List<Detail>.from(json['detail'].map((x) => Detail.fromJson(x))),
    );
  }


}

class Detail {
  final int id;
  final String gallaryType;
  final int gallaryHeight;
  final int gallaryWidth;
  final String gallaryPath;

  Detail({
    required this.id,
    required this.gallaryType,
    required this.gallaryHeight,
    required this.gallaryWidth,
    required this.gallaryPath,
  });

  factory Detail.fromJson(Map<String, dynamic> json) {
    return Detail(
      id: json['id'],
      gallaryType: json['gallary_type'],
      gallaryHeight: json['gallary_height'],
      gallaryWidth: json['gallary_width'],
      gallaryPath: json['gallary_path'],
    );
  }


}
