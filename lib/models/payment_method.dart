class PaymentMethod {
  int? paymentMethodId;
  String? paymentMethodName;
  String? paymentMethodTitle;
  String? paymentMethodType;
  var paymentMethodStatus;
  var paymentMethodEnvironment;
  var paymentMethodDefault;

  PaymentMethod(
      { this.paymentMethodId,
         this.paymentMethodName,
         this.paymentMethodTitle,
         this.paymentMethodType,
         this.paymentMethodStatus,
         this.paymentMethodEnvironment,
         this.paymentMethodDefault});

  PaymentMethod.fromJson(Map<String, dynamic> json) {
    paymentMethodId = json['payment_method_id'];
    paymentMethodName = json['payment_method_name'];
    paymentMethodTitle = json['payment_method_title'];
    paymentMethodType = json['payment_method_type'];
    paymentMethodStatus = json['payment_method_status'];
    paymentMethodEnvironment = json['payment_method_environment'];
    paymentMethodDefault = json['payment_method_default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['payment_method_id'] = paymentMethodId;
    data['payment_method_name'] = paymentMethodName;
    data['payment_method_title'] = paymentMethodTitle;
    data['payment_method_type'] = paymentMethodType;
    data['payment_method_status'] = paymentMethodStatus;
    data['payment_method_environment'] = paymentMethodEnvironment;
    data['payment_method_default'] = paymentMethodDefault;
    return data;
  }
}