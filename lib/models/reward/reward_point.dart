class RewardPoint {
  int? id;
  String? referenceId;
  var points;
  String? description;
  String? customerId;
  CustomerDetail? customerDetail;

  RewardPoint(
      {this.id,
        this.referenceId,
        this.points,
        this.description,
        this.customerId,
        this.customerDetail});

  RewardPoint.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    referenceId = json['reference_id'];
    points = json['points'];
    description = json['description'];
    customerId = json['customer_id'];
    customerDetail = json['customer_detail'] != null
        ? CustomerDetail.fromJson(json['customer_detail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['reference_id'] = referenceId;
    data['points'] = points;
    data['description'] = description;
    data['customer_id'] = customerId;
    if (customerDetail != null) {
      data['customer_detail'] = customerDetail?.toJson();
    }
    return data;
  }
}

class CustomerDetail {
  int? customerId;
  String? customerFirstName;
  String? customerLastName;
  String? customerEmail;
  String? customerHash;
  String? isSeen;
  String? customerStatus;
  List<CustomerAddress>? customerAddress;

  CustomerDetail(
      {this.customerId,
        this.customerFirstName,
        this.customerLastName,
        this.customerEmail,
        this.customerHash,
        this.isSeen,
        this.customerStatus,
        this.customerAddress});

  CustomerDetail.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    customerFirstName = json['customer_first_name'];
    customerLastName = json['customer_last_name'];
    customerEmail = json['customer_email'];
    customerHash = json['customer_hash'];
    isSeen = json['is_seen'];
    customerStatus = json['customer_status'];
    if (json['customer_address'] != null) {
      customerAddress = <CustomerAddress>[];
      json['customer_address'].forEach((v) {
        customerAddress?.add(CustomerAddress.fromJson(v));
      });
    }
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
    if (customerAddress != null) {
      data['customer_address'] =
          customerAddress?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomerAddress {
  int? id;
  String? gender;
  String? company;
  String? streetAddress;
  String? suburb;
  String? phone;
  String? postcode;
  String? dob;
  String? city;
  CountryId? countryId;
  StateId? stateId;
  String? lattitude;
  String? longitude;
  String? defaultAddress;

  CustomerAddress(
      {this.id,
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
        this.lattitude,
        this.longitude,
        this.defaultAddress});

  CustomerAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gender = json['gender'];
    company = json['company'];
    streetAddress = json['street_address'];
    suburb = json['suburb'];
    phone = json['phone'];
    postcode = json['postcode'];
    dob = json['dob'];
    city = json['city'];
    countryId = json['country_id'] != null
        ? CountryId.fromJson(json['country_id'])
        : null;
    stateId = json['state_id'] != null
        ? StateId.fromJson(json['state_id'])
        : null;
    lattitude = json['lattitude'];
    longitude = json['longitude'];
    defaultAddress = json['default_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['gender'] = gender;
    data['company'] = company;
    data['street_address'] = streetAddress;
    data['suburb'] = suburb;
    data['phone'] = phone;
    data['postcode'] = postcode;
    data['dob'] = dob;
    data['city'] = city;
    if (countryId != null) {
      data['country_id'] = countryId?.toJson();
    }
    if (stateId != null) {
      data['state_id'] = stateId?.toJson();
    }
    data['lattitude'] = lattitude;
    data['longitude'] = longitude;
    data['default_address'] = defaultAddress;
    return data;
  }
}

class CountryId {
  int? countryId;
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
  String? countryId;

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