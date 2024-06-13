

class ShipmentCreateResponse {
  final String status;
  final String message;

  ShipmentCreateResponse({
    required this.status,
    required this.message,
  });

  factory ShipmentCreateResponse.fromJson(Map<String, dynamic> json) {
    return ShipmentCreateResponse(
      status: json['status'],
      message: json['message'],
    );
  }
}