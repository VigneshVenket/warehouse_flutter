
class ShippingCost{
  final double totalAmount;

  ShippingCost({
    required this.totalAmount,
  });


  factory ShippingCost.fromJson(Map<String, dynamic> json) {
    return ShippingCost(
      totalAmount: json['total_amount'],
    );
  }
}
