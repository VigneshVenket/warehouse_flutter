class RewardnResponse {
  RewardnResponse({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  double? data;

  factory RewardnResponse.fromJson(Map<String, dynamic> json) => RewardnResponse(
    status: json["status"],
    message: json["message"],
    data: json["data"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data,
  };
}
