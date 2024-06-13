class ShipmentsData {
  final String name;
  final String add;
  final String pin;
  final String city;
  final String state;
  final String country;
  final String phone;
  // final int order;
  final String paymentMode;
  final double codAmount;
  final String orderDate;
  final String waybill;
  final double shipmentWidth;
  final double shipmentHeight;
  final double weight;
  final String shippingMode;
  final String addressType;
  final String products_desc;
  final num quantity;

  ShipmentsData({
    required this.name,
    required this.add,
    required this.pin,
    required this.city,
    required this.state,
    required this.country,
    required this.phone,
    // required this.order,
    required this.paymentMode,
    required this.codAmount,
    required this.orderDate,
    required this.waybill,
    required this.shipmentWidth,
    required this.shipmentHeight,
    required this.weight,
    required this.shippingMode,
    required this.addressType,
    required this.products_desc,
    required this.quantity
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'add': add,
      'pin': pin,
      'city': city,
      'state': state,
      'country': country,
      'phone': phone,
      // 'order': order,
      'payment_mode': paymentMode,
      'cod_amount': codAmount,
      'order_date': orderDate,
      'waybill': waybill,
      'shipment_width': shipmentWidth,
      'shipment_height': shipmentHeight,
      'weight': weight,
      'shipping_mode': shippingMode,
      'address_type': addressType,
      'products_desc':products_desc,
      'quantity':quantity
    };
  }
}

class PickupLocation {
  final String name;
  final String add;
  final String city;
  final String pinCode;
  final String country;
  final String phone;

  PickupLocation({
    required this.name,
    required this.add,
    required this.city,
    required this.pinCode,
    required this.country,
    required this.phone,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'add': add,
      'city': city,
      'pin_code': pinCode,
      'country': country,
      'phone': phone,
    };
  }
}

class ShipmentCreateData {
  final List<ShipmentsData> shipments;
  final PickupLocation pickupLocation;

  ShipmentCreateData({
    required this.shipments,
    required this.pickupLocation,
  });

  Map<String, dynamic> toJson() {
    return {
      'shipments': shipments.map((shipment) => shipment.toJson()).toList(),
      'pickup_location': pickupLocation.toJson(),
    };
  }
}