class Order {
  int id;
  int customerId;
  int? deliveryBoyId;
  int warehouseId;
  String orderFrom;
  String billingFirstName;
  String billingLastName;
  String? billingCompany;
  String billingStreetAddress;
  String? billingSuburb;
  String billingCity;
  String billingPostcode;
  int billingCountry;
  int billingState;
  String billingPhone;
  String deliveryFirstName;
  String deliveryLastName;
  String? deliveryCompany;
  String deliveryStreetAddress;
  String? deliverySuburb;
  String deliveryCity;
  String deliveryPostcode;
  int deliveryCountry;
  int deliveryState;
  String deliveryPhone;
  String paymentStatus;
  String latlong;
  double orderPrice;
  num shippingCost;
  double totalTax;
  String paymentMethod;
  String orderStatus;
  String waybill;
  DateTime createdAt;
  DateTime updatedAt;

  Order({
    required this.id,
    required this.customerId,
    this.deliveryBoyId,
    required this.warehouseId,
    required this.orderFrom,
    required this.billingFirstName,
    required this.billingLastName,
    this.billingCompany,
    required this.billingStreetAddress,
    this.billingSuburb,
    required this.billingCity,
    required this.billingPostcode,
    required this.billingCountry,
    required this.billingState,
    required this.billingPhone,
    required this.deliveryFirstName,
    required this.deliveryLastName,
    this.deliveryCompany,
    required this.deliveryStreetAddress,
    this.deliverySuburb,
    required this.deliveryCity,
    required this.deliveryPostcode,
    required this.deliveryCountry,
    required this.deliveryState,
    required this.deliveryPhone,
    required this.paymentStatus,
    required this.latlong,
    required this.orderPrice,
    required this.shippingCost,
    required this.totalTax,
    required this.paymentMethod,
    required this.orderStatus,
    required this.waybill,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      customerId: json['customer_id'],
      deliveryBoyId: json['delivery_boy_id'],
      warehouseId: json['warehouse_id'],
      orderFrom: json['order_from'],
      billingFirstName: json['billing_first_name'],
      billingLastName: json['billing_last_name'],
      billingCompany: json['billing_company'],
      billingStreetAddress: json['billing_street_aadress'],
      billingSuburb: json['billing_suburb'],
      billingCity: json['billing_city'],
      billingPostcode: json['billing_postcode'],
      billingCountry: json['billing_country'],
      billingState: json['billing_state'],
      billingPhone: json['billing_phone'],
      deliveryFirstName: json['delivery_first_name'],
      deliveryLastName: json['delivery_last_name'],
      deliveryCompany: json['delivery_company'],
      deliveryStreetAddress: json['delivery_street_aadress'],
      deliverySuburb: json['delivery_suburb'],
      deliveryCity: json['delivery_city'],
      deliveryPostcode: json['delivery_postcode'],
      deliveryCountry: json['delivery_country'],
      deliveryState: json['delivery_state'],
      deliveryPhone: json['delivery_phone'],
      paymentStatus: json['payment_status'],
      latlong: json['latlong'],
      orderPrice: json['order_price'],
      shippingCost: json['shipping_cost'],
      totalTax: json['total_tax'],
      paymentMethod: json['payment_method'],
      orderStatus: json['order_status'],
      waybill: json['waybill'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}


class Shipment {
  String status;
  String client;
  String? sortCode;
  List<String> remarks;
  String waybill;
  num codAmount;
  String payment;
  bool serviceable;
  String refnum;

  Shipment({
    required this.status,
    required this.client,
    this.sortCode,
    required this.remarks,
    required this.waybill,
    required this.codAmount,
    required this.payment,
    required this.serviceable,
    required this.refnum,
  });

  factory Shipment.fromJson(Map<String, dynamic> json) {
    return Shipment(
      status: json['status'],
      client: json['client'],
      sortCode: json['sort_code'],
      remarks: List<String>.from(json['remarks']),
      waybill: json['waybill'],
      codAmount: json['cod_amount'],
      payment: json['payment'],
      serviceable: json['serviceable'],
      refnum: json['refnum'],
    );
  }
}

