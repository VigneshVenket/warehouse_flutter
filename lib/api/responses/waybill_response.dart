

class WaybillResponse {
  final String waybill;

  WaybillResponse({
    required this.waybill,
  });

  factory WaybillResponse.fromJson(Map<String, dynamic> json) {
    return WaybillResponse(
      waybill: json['waybill']
    );
  }
}