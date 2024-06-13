

import 'dart:convert';

import 'package:flutter_kundol/blocs/shipmentwithcity/shipment_state.dart';

import '../../constants/app_constants.dart';
import '../../models/shipping_cost.dart';

// class ShippingCostResponse{
//
//   List<ShippingCost>? data;
//
//   ShippingCostResponse({
//     required this.data,
//   });
//
//     ShippingCostResponse.fromJson(Map<String, dynamic> json) {
//     // List<ShippingCost> shippingCosts = json.entries.map((shippingCostData) => ShippingCost.fromJson(shippingCostData.value)).toList();
//     // List<dynamic> jsonlist=json.decode(data as String);
//     //
//     // return ShippingCostResponse(shippingCosts: shippingCosts);
//
//     if (json['data'] != null) {
//       data = <ShippingCost>[];
//         json['data'].forEach((v) {
//         data?.add(ShippingCost.fromJson(v));
//       });
//     }
//
//    //  // status = json['status'];
//    //  data = ShippingCost.fromJson(json['data']);
//    // return ShippingCostResponse(data: data);
//   }
//
// }


class ShippingCostResponse {
  final double data;

  ShippingCostResponse({
    required this.data,
  });

  factory ShippingCostResponse.fromJson(Map<String, dynamic> json) {
    return ShippingCostResponse(
      // data: json['total_amount'] != null ? ShippingCost.fromJson(json['total_amount']) : null,
      data: json['total_amount'].toDouble()
    );
  }
}