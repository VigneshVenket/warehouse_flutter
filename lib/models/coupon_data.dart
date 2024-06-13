class CouponData {
  String? couponCode;
  String? description;
  var amount;
  String? type;

  CouponData(
      {this.couponCode,
        this.description,
        this.amount,
        this.type});

  CouponData.fromJson(Map<String, dynamic> json) {
    couponCode = json['coupon_code'];
    description = json['description'];
    amount = json['amount'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['coupon_code'] = couponCode;
    data['description'] = description;
    data['amount'] = amount;
    data['type'] = type;
    return data;
  }
}
