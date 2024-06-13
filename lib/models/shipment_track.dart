
import 'package:flutter/foundation.dart';

// class ShipmentTrack{
//    Shipment? shipment;
//
//    ShipmentTrack({this.shipment});
//
//    ShipmentTrack.fromJson(Map<String, dynamic> json){
//     if (json['Shipment'] != null) {
//       shipment=Shipment.fromJson(json['Shipment']);
//     }
//   }
//
// }
//
//
// class Shipment {
//   final String pickUpDate;
//   final int destination;
//   final String? destRecieveDate;
//   final List<ScanDetail> scans;
//   final Status status;
//   final dynamic returnPromisedDeliveryDate;
//   final List<dynamic> ewaybill;
//   final int invoiceAmount;
//   final dynamic chargedWeight;
//   final dynamic pickedupDate;
//   final dynamic deliveryDate;
//   final String senderName;
//   final String awb;
//   final int dispatchCount;
//   final String orderType;
//   final dynamic returnedDate;
//   final dynamic expectedDeliveryDate;
//   final dynamic rtoStartedDate;
//   final String extras;
//   final dynamic firstAttemptDate;
//   final bool reverseInTransit;
//   final dynamic quantity;
//   final String origin;
//   final Consignee consignee;
//   final String referenceNo;
//   final dynamic outDestinationDate;
//   final int codAmount;
//   final dynamic promisedDeliveryDate;
//   final String pickupLocation;
//   final dynamic originRecieveDate;
//
//   Shipment({
//     required this.pickUpDate,
//     required this.destination,
//     required this.destRecieveDate,
//     required this.scans,
//     required this.status,
//     required this.returnPromisedDeliveryDate,
//     required this.ewaybill,
//     required this.invoiceAmount,
//     required this.chargedWeight,
//     required this.pickedupDate,
//     required this.deliveryDate,
//     required this.senderName,
//     required this.awb,
//     required this.dispatchCount,
//     required this.orderType,
//     required this.returnedDate,
//     required this.expectedDeliveryDate,
//     required this.rtoStartedDate,
//     required this.extras,
//     required this.firstAttemptDate,
//     required this.reverseInTransit,
//     required this.quantity,
//     required this.origin,
//     required this.consignee,
//     required this.referenceNo,
//     required this.outDestinationDate,
//     required this.codAmount,
//     required this.promisedDeliveryDate,
//     required this.pickupLocation,
//     required this.originRecieveDate,
//   });
//
//   factory Shipment.fromJson(Map<String, dynamic> json) {
//     var scanList = json['Scans'] as List;
//     List<ScanDetail> scans = scanList.map((data) => ScanDetail.fromJson(data['ScanDetail'])).toList();
//
//     return Shipment(
//       pickUpDate: json['PickUpDate'],
//       destination: json['Destination'],
//       destRecieveDate: json['DestRecieveDate'],
//       scans: scans,
//       status: Status.fromJson(json['Status']),
//       returnPromisedDeliveryDate: json['ReturnPromisedDeliveryDate'],
//       ewaybill: json['Ewaybill'],
//       invoiceAmount: json['InvoiceAmount'],
//       chargedWeight: json['ChargedWeight'],
//       pickedupDate: json['PickedupDate'],
//       deliveryDate: json['DeliveryDate'],
//       senderName: json['SenderName'],
//       awb: json['AWB'],
//       dispatchCount: json['DispatchCount'],
//       orderType: json['OrderType'],
//       returnedDate: json['ReturnedDate'],
//       expectedDeliveryDate: json['ExpectedDeliveryDate'],
//       rtoStartedDate: json['RTOStartedDate'],
//       extras: json['Extras'],
//       firstAttemptDate: json['FirstAttemptDate'],
//       reverseInTransit: json['ReverseInTransit'],
//       quantity: json['Quantity'],
//       origin: json['Origin'],
//       consignee: Consignee.fromJson(json['Consignee']),
//       referenceNo: json['ReferenceNo'],
//       outDestinationDate: json['OutDestinationDate'],
//       codAmount: json['CODAmount'],
//       promisedDeliveryDate: json['PromisedDeliveryDate'],
//       pickupLocation: json['PickupLocation'],
//       originRecieveDate: json['OriginRecieveDate'],
//     );
//   }
// }
//
// class ScanDetail {
//   final String scanDateTime;
//   final String scanType;
//   final String scan;
//   final String statusDateTime;
//   final String scannedLocation;
//   final String instructions;
//   final String statusCode;
//
//   ScanDetail({
//     required this.scanDateTime,
//     required this.scanType,
//     required this.scan,
//     required this.statusDateTime,
//     required this.scannedLocation,
//     required this.instructions,
//     required this.statusCode,
//   });
//
//   factory ScanDetail.fromJson(Map<String, dynamic> json) {
//     return ScanDetail(
//       scanDateTime: json['ScanDateTime'],
//       scanType: json['ScanType'],
//       scan: json['Scan'],
//       statusDateTime: json['StatusDateTime'],
//       scannedLocation: json['ScannedLocation'],
//       instructions: json['Instructions'],
//       statusCode: json['StatusCode'],
//     );
//   }
// }
//
// class Status {
//   final String status;
//   final String statusLocation;
//   final String instructions;
//   final String receivedBy;
//   final String statusCode;
//   final String statusDateTime;
//   final String statusType;
//
//   Status({
//     required this.status,
//     required this.statusLocation,
//     required this.instructions,
//     required this.receivedBy,
//     required this.statusCode,
//     required this.statusDateTime,
//     required this.statusType,
//   });
//
//   factory Status.fromJson(Map<String, dynamic> json) {
//     return Status(
//       status: json['Status'],
//       statusLocation: json['StatusLocation'],
//       instructions: json['Instructions'],
//       receivedBy: json['RecievedBy'],
//       statusCode: json['StatusCode'],
//       statusDateTime: json['StatusDateTime'],
//       statusType: json['StatusType'],
//     );
//   }
// }
//
// class Consignee {
//   final int city;
//   final String name;
//   final String country;
//   final List<dynamic> address2;
//   final String address3;
//   final String pinCode;
//   final String state;
//   final String telephone2;
//   final String telephone1;
//   final List<dynamic> address1;
//
//   Consignee({
//     required this.city,
//     required this.name,
//     required this.country,
//     required this.address2,
//     required this.address3,
//     required this.pinCode,
//     required this.state,
//     required this.telephone2,
//     required this.telephone1,
//     required this.address1,
//   });
//
//   factory Consignee.fromJson(Map<String, dynamic> json) {
//     return Consignee(
//       city: json['City'],
//       name: json['Name'],
//       country: json['Country'],
//       address2: json['Address2'],
//       address3: json['Address3'],
//       pinCode: json['PinCode'],
//       state: json['State'],
//       telephone2: json['Telephone2'],
//       telephone1: json['Telephone1'],
//       address1: json['Address1'],
//     );
//   }
// }


class ShipmentTrack {
  final Shipment shipment;

  ShipmentTrack({required this.shipment});

  factory ShipmentTrack.fromJson(Map<String, dynamic> json) {
    return ShipmentTrack(
      shipment: Shipment.fromJson(json['Shipment']),
    );
  }
}

class Shipment {
  final String pickUpDate;
  final String destination;
  final dynamic destRecieveDate;
  final List<ScanDetail> scans;
  final Status status;
  final dynamic returnPromisedDeliveryDate;
  final List<dynamic> ewaybill;
  final int invoiceAmount;
  final dynamic chargedWeight;
  final dynamic pickedupDate;
  final dynamic deliveryDate;
  final String senderName;
  final String awb;
  final int dispatchCount;
  final String orderType;
  final dynamic returnedDate;
  final dynamic expectedDeliveryDate;
  final dynamic rtoStartedDate;
  final String extras;
  final dynamic firstAttemptDate;
  final bool reverseInTransit;
  final String quantity;
  final String origin;
  final Consignee consignee;
  final String referenceNo;
  final dynamic outDestinationDate;
  final int codAmount;
  final dynamic promisedDeliveryDate;
  final String pickupLocation;
  final dynamic originRecieveDate;

  Shipment({
    required this.pickUpDate,
    required this.destination,
    required this.destRecieveDate,
    required this.scans,
    required this.status,
    required this.returnPromisedDeliveryDate,
    required this.ewaybill,
    required this.invoiceAmount,
    required this.chargedWeight,
    required this.pickedupDate,
    required this.deliveryDate,
    required this.senderName,
    required this.awb,
    required this.dispatchCount,
    required this.orderType,
    required this.returnedDate,
    required this.expectedDeliveryDate,
    required this.rtoStartedDate,
    required this.extras,
    required this.firstAttemptDate,
    required this.reverseInTransit,
    required this.quantity,
    required this.origin,
    required this.consignee,
    required this.referenceNo,
    required this.outDestinationDate,
    required this.codAmount,
    required this.promisedDeliveryDate,
    required this.pickupLocation,
    required this.originRecieveDate,
  });

  factory Shipment.fromJson(Map<String, dynamic> json) {
    var scanList = json['Scans'] as List;
    List<ScanDetail> scans = scanList.map((data) => ScanDetail.fromJson(data['ScanDetail'])).toList();

    return Shipment(
      pickUpDate: json['PickUpDate'],
      destination: json['Destination'],
      destRecieveDate: json['DestRecieveDate'],
      scans: scans,
      status: Status.fromJson(json['Status']),
      returnPromisedDeliveryDate: json['ReturnPromisedDeliveryDate'],
      ewaybill: json['Ewaybill'],
      invoiceAmount: json['InvoiceAmount'],
      chargedWeight: json['ChargedWeight'],
      pickedupDate: json['PickedupDate'],
      deliveryDate: json['DeliveryDate'],
      senderName: json['SenderName'],
      awb: json['AWB'],
      dispatchCount: json['DispatchCount'],
      orderType: json['OrderType'],
      returnedDate: json['ReturnedDate'],
      expectedDeliveryDate: json['ExpectedDeliveryDate'],
      rtoStartedDate: json['RTOStartedDate'],
      extras: json['Extras'],
      firstAttemptDate: json['FirstAttemptDate'],
      reverseInTransit: json['ReverseInTransit'],
      quantity: json['Quantity'],
      origin: json['Origin'],
      consignee: Consignee.fromJson(json['Consignee']),
      referenceNo: json['ReferenceNo'],
      outDestinationDate: json['OutDestinationDate'],
      codAmount: json['CODAmount'],
      promisedDeliveryDate: json['PromisedDeliveryDate'],
      pickupLocation: json['PickupLocation'],
      originRecieveDate: json['OriginRecieveDate'],
    );
  }
}

class ScanDetail {
  final String scanDateTime;
  final String scanType;
  final String scan;
  final String statusDateTime;
  final String scannedLocation;
  final String instructions;
  final String statusCode;

  ScanDetail({
    required this.scanDateTime,
    required this.scanType,
    required this.scan,
    required this.statusDateTime,
    required this.scannedLocation,
    required this.instructions,
    required this.statusCode,
  });

  factory ScanDetail.fromJson(Map<String, dynamic> json) {
    return ScanDetail(
      scanDateTime: json['ScanDateTime'],
      scanType: json['ScanType'],
      scan: json['Scan'],
      statusDateTime: json['StatusDateTime'],
      scannedLocation: json['ScannedLocation'],
      instructions: json['Instructions'],
      statusCode: json['StatusCode'],
    );
  }
}

class Status {
  final String status;
  final String statusLocation;
  final String statusDateTime;
  final String recievedBy;
  final String instructions;
  final String statusType;
  final String statusCode;

  Status({
    required this.status,
    required this.statusLocation,
    required this.instructions,
    required this.recievedBy,
    required this.statusCode,
    required this.statusDateTime,
    required this.statusType,
  });

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      status: json['Status'],
      statusLocation: json['StatusLocation'],
      instructions: json['Instructions'],
      recievedBy: json['RecievedBy'],
      statusCode: json['StatusCode'],
      statusDateTime: json['StatusDateTime'],
      statusType: json['StatusType'],
    );
  }
}

class Consignee {
  final String city;
  final String name;
  final String country;
  final List<dynamic> address2;
  final String address3;
  final int pinCode;
  final String state;
  final String telephone2;
  final String telephone1;
  final List<dynamic> address1;

  Consignee({
    required this.city,
    required this.name,
    required this.country,
    required this.address2,
    required this.address3,
    required this.pinCode,
    required this.state,
    required this.telephone2,
    required this.telephone1,
    required this.address1,
  });

  factory Consignee.fromJson(Map<String, dynamic> json) {
    return Consignee(
      city: json['City'],
      name: json['Name'],
      country: json['Country'],
      address2: json['Address2'],
      address3: json['Address3'],
      pinCode: json['PinCode'],
      state: json['State'],
      telephone2: json['Telephone2'],
      telephone1: json['Telephone1'],
      address1: json['Address1'],
    );
  }
}

