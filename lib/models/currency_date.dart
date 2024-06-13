class CurrencyData {
  int? currencyId;
  String? title;
  String? code;
  String? symbolPosition;
  String? value;
  var exchangeRate;
  var decimalPoint;
  String? thousandPoint;
  String? decimalPlace;
  var isDefault;
  String? status;
  CountryId? countryId;

  CurrencyData(
      {this.currencyId,
        this.title,
        this.code,
        this.symbolPosition,
        this.value,
        this.exchangeRate,
        this.decimalPoint,
        this.thousandPoint,
        this.decimalPlace,
        this.isDefault,
        this.status,
        this.countryId});

  CurrencyData.fromJson(Map<String, dynamic> json) {
    currencyId = json['currency_id'];
    title = json['title'];
    code = json['code'];
    symbolPosition = json['symbol_position'];
    value = json['value'];
    exchangeRate = json['exchange_rate'];
    decimalPoint = json['decimal_point'];
    thousandPoint = json['thousand_point'];
    decimalPlace = json['decimal_place'];
    isDefault = json['is_default'];
    status = json['status'];
    countryId = json['country_id'] != null
        ? CountryId.fromJson(json['country_id'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currency_id'] = currencyId;
    data['title'] = title;
    data['code'] = code;
    data['symbol_position'] = symbolPosition;
    data['value'] = value;
    data['exchange_rate'] = exchangeRate;
    data['decimal_point'] = decimalPoint;
    data['thousand_point'] = thousandPoint;
    data['decimal_place'] = decimalPlace;
    data['is_default'] = isDefault;
    data['status'] = status;
    if (countryId != null) {
      data['country_id'] = countryId?.toJson();
    }
    return data;
  }
}

class CountryId {
  int? id;
  String? name;
  String? isoCode2;
  String? isoCode3;
  String? addressFormatId;
  String? countryCode;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  CountryId(
      {this.id,
        this.name,
        this.isoCode2,
        this.isoCode3,
        this.addressFormatId,
        this.countryCode,
        this.deletedAt,
        this.createdAt,
        this.updatedAt});

  CountryId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isoCode2 = json['iso_code_2'];
    isoCode3 = json['iso_code_3'];
    addressFormatId = json['address_format_id'];
    countryCode = json['country_code'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['iso_code_2'] = isoCode2;
    data['iso_code_3'] = isoCode3;
    data['address_format_id'] = addressFormatId;
    data['country_code'] = countryCode;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Links {
  String? first;
  String? last;
  String? prev;
  String? next;

  Links({this.first, this.last, this.prev, this.next});

  Links.fromJson(Map<String, dynamic> json) {
    first = json['first'];
    last = json['last'];
    prev = json['prev'];
    next = json['next'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first'] = first;
    data['last'] = last;
    data['prev'] = prev;
    data['next'] = next;
    return data;
  }
}

class Meta {
  int? currentPage;
  int? from;
  int? lastPage;
  List<Links>? links;
  String? path;
  int? perPage;
  int? to;
  int? total;

  Meta(
      {this.currentPage,
        this.from,
        this.lastPage,
        this.links,
        this.path,
        this.perPage,
        this.to,
        this.total});

  Meta.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    from = json['from'];
    lastPage = json['last_page'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links?.add(Links.fromJson(v));
      });
    }
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    data['from'] = from;
    data['last_page'] = lastPage;
    if (links != null) {
      data['links'] = links?.map((v) => v.toJson()).toList();
    }
    data['path'] = path;
    data['per_page'] = perPage;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}