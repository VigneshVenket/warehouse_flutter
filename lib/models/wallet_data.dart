import 'package:flutter_kundol/constants/app_constants.dart';

class WalletResponse {
  WalletResponse({
    this.data,
    this.links,
    this.meta,
    this.status,
    this.message,
    this.statusCode,
  });

  List<wallet>? data;
  Links? links;
  Meta? meta;
  String? status;
  String? message;
  int? statusCode;

  factory WalletResponse.fromJson(Map<String, dynamic> json) => WalletResponse(
    data: List<wallet>.from(json["data"].map((x) => wallet.fromJson(x))),
    links: Links.fromJson(json["links"]),
    meta: Meta.fromJson(json["meta"]),
    status: json["status"],
    message: json["message"],
    statusCode: json["status_code"],
  );

  WalletResponse.withError(String error) {
    data = null;
    status = AppConstants.STATUS_ERROR;
    message = error;
    statusCode = 0;
  }

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "links": links?.toJson(),
    "meta": meta?.toJson(),
    "status": status,
    "message": message,
    "status_code": statusCode,
  };
}

class wallet {
  wallet({
    this.id,
    this.transactionDescription,
    this.accountId,
    this.referenceId,
    this.userId,
    this.type,
    this.warehouse,
    this.debitAmount,
    this.creditAmount,
    required this.description,
    this.date,
  });

  int? id;
  String? transactionDescription;
  var accountId;
  var referenceId;
  var userId;
  Type? type;
  dynamic warehouse;
  var debitAmount;
  var creditAmount;
  String? description;
  String? date;


  factory wallet.fromJson(Map<String, dynamic> json) => wallet(
    id: json["id"],
    transactionDescription: json["transaction_description"],
    accountId: json["account_id"],
    referenceId: json["reference_id"],
    userId: json["user_id"],
    type: typeValues.map[json["type"]],
    warehouse: json["warehouse"],
    debitAmount: json["debit_amount"],
    creditAmount: json["credit_amount"],
    description: json["description"] == null ? null : json["description"],
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "transaction_description": transactionDescription,
    "account_id": accountId,
    "reference_id": referenceId,
    "user_id": userId,
    "type": typeValues.reverse[type],
    "warehouse": warehouse,
    "debit_amount": debitAmount,
    "credit_amount": creditAmount,
    "description": description == null ? null : description,
    "date": date,
  };
}

enum Type { REDEEM, SALE, EMPTY }

final typeValues = EnumValues({
  "": Type.EMPTY,
  "redeem": Type.REDEEM,
  "sale": Type.SALE
});

class Links {
  Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  String? first;
  String? last;
  dynamic prev;
  dynamic next;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    first: json["first"],
    last: json["last"],
    prev: json["prev"],
    next: json["next"],
  );

  Map<String, dynamic> toJson() => {
    "first": first,
    "last": last,
    "prev": prev,
    "next": next,
  };
}

class Meta {
  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.links,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  int? currentPage;
  int? from;
  int? lastPage;
  List<Link>? links;
  String? path;
  int? perPage;
  int? to;
  int? total;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    currentPage: json["current_page"],
    from: json["from"],
    lastPage: json["last_page"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    path: json["path"],
    perPage: json["per_page"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "from": from,
    "last_page": lastPage,
    "links": List<dynamic>.from(links!.map((x) => x.toJson())),
    "path": path,
    "per_page": perPage,
    "to": to,
    "total": total,
  };
}

class Link {
  Link({
    this.url,
    this.label,
    this.active,
  });

  String? url;
  String? label;
  bool? active;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"] == null ? null : json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url == null ? null : url,
    "label": label,
    "active": active,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
