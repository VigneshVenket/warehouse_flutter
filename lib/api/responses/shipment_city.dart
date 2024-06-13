class ShipmentCitysResponse {
    ShipmentCitysResponse({
        this.status,
        this.shippingCost,
    });

    String? status;
    var shippingCost;

    factory ShipmentCitysResponse.fromJson(Map<String, dynamic> json) => ShipmentCitysResponse(
        status: json["status"],
        shippingCost: json["shipping_cost"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "shipping_cost": shippingCost,
    };
}
