class ShipmentResponse {
    ShipmentResponse({
        this.status,
        this.shippingCost,
    });

    String? status;
    String? shippingCost;

    factory ShipmentResponse.fromJson(Map<String, dynamic> json) => ShipmentResponse(
        status: json["status"],
        shippingCost: json["shipping_cost"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "shipping_cost": shippingCost,
    };
}
