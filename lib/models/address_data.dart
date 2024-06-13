import 'dart:convert';

import 'package:flutter_kundol/blocs/cityy/city_state.dart';

class AddressData {
  int? id;
  AddressCustomer? customer;
  String? gender;
  String? company;
  String? streetAddress;
  String? suburb;
  String? phone;
  String? postcode;
  String? dob;
  // String? city;
  var countryId;
  StateId ?stateId;
  String? city;
  String? lattitude;
  var longitude;
  var defaultAddress;

  AddressData(
      {this.id,
      this.customer,
      this.gender,
      this.company,
      this.streetAddress,
      this.suburb,
      this.phone,
      this.postcode,
      this.dob,
      this.city,
      this.countryId,
      this.stateId,
      // this.city,
      this.lattitude,
      this.longitude,
      this.defaultAddress});

  AddressData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customer = json['customer'] != null
        ? AddressCustomer.fromJson(json['customer'])
        : null;
    gender = json['gender'];
    company = json['company'];
    streetAddress = json['street_address'];
    suburb = json['suburb'];
    phone = json['phone'];
    postcode = json['postcode'];
    dob = json['dob'];

    countryId = json['country_id'] != null
        ? CountryId.fromJson(json['country_id'])
        : null;
    stateId =
        json['state_id'] != null ? StateId.fromJson(json['state_id']) : null;

    if (json['city'] != null) {
      city = json['city'];
    } else {
      city = null;
    }

    lattitude = json['lattitude'];
    longitude = json['longitude'];
    defaultAddress = json['default_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (customer != null) {
      data['customer'] = customer?.toJson();
    }
    data['gender'] = gender;
    data['company'] = company;
    data['street_address'] = streetAddress;
    data['suburb'] = suburb;
    data['phone'] = phone;
    data['postcode'] = postcode;
    data['dob'] = dob;
    // data['city'] = city;
    if (countryId != null) {
      data['country_id'] = countryId?.toJson();
    }
    if (stateId != null) {
      data['state_id'] = stateId?.toJson();
    }
    if (city != null) {
      data['city'] = CityyLoading();
    }
    data['lattitude'] = lattitude;
    data['longitude'] = longitude;
    data['default_address'] = defaultAddress;
    return data;
  }
}

class AddressCustomer {
  int? customerId;
  String? customerFirstName;
  String? customerLastName;
  String? customerEmail;
  String? customerHash;
  String? isSeen;
  String? customerStatus;

  AddressCustomer(
      {this.customerId,
      this.customerFirstName,
      this.customerLastName,
      this.customerEmail,
      this.customerHash,
      this.isSeen,
      this.customerStatus});

  AddressCustomer.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    customerFirstName = json['customer_first_name'];
    customerLastName = json['customer_last_name'];
    customerEmail = json['customer_email'];
    customerHash = json['customer_hash'];
    isSeen = json['is_seen'];
    customerStatus = json['customer_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customer_id'] = customerId;
    data['customer_first_name'] = customerFirstName;
    data['customer_last_name'] = customerLastName;
    data['customer_email'] = customerEmail;
    data['customer_hash'] = customerHash;
    data['is_seen'] = isSeen;
    data['customer_status'] = customerStatus;
    return data;
  }
}

class CountryId {
  var countryId;
  String? countryName;

  CountryId({this.countryId, this.countryName});

  CountryId.fromJson(Map<String, dynamic> json) {
    countryId = json['country_id'];
    countryName = json['country_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['country_id'] = countryId;
    data['country_name'] = countryName;
    return data;
  }
}

class StateId {
  int? id;
  String? name;
  var countryId;

  StateId({this.id, this.name, this.countryId});

  StateId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    countryId = json['country_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['country_id'] = countryId;
    return data;
  }
}

