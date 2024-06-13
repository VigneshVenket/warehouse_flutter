class RewardDes {
  RewardDes({
    this.data,
    this.links,
    this.meta,
    this.status,
    this.message,
    this.statusCode,
  });

  List<Datum>? data;
  Links? links;
  Meta? meta;
  String? status;
  String? message;
  int? statusCode;

  factory RewardDes.fromJson(Map<String, dynamic> json) => RewardDes(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    links: Links.fromJson(json["links"]),
    meta: Meta.fromJson(json["meta"]),
    status: json["status"],
    message: json["message"],
    statusCode: json["status_code"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "links": links?.toJson(),
    "meta": meta?.toJson(),
    "status": status,
    "message": message,
    "status_code": statusCode,
  };
}

class Datum {
  Datum({
    this.id,
    this.referenceId,
    this.points,
    this.description,
    this.customerId,
    this.customerDetail,
  });

  int? id;
  var referenceId;
  var points;
  String? description;
  var customerId;
  CustomerDetail? customerDetail;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    referenceId: json["reference_id"],
    points: json["points"],
    description: json["description"],
    customerId: json["customer_id"],
    customerDetail: CustomerDetail.fromJson(json["customer_detail"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "reference_id": referenceId,
    "points": points,
    "description": description,
    "customer_id": customerId,
    "customer_detail": customerDetail?.toJson(),
  };
}

class CustomerDetail {
  CustomerDetail({
    this.customerId,
    this.customerFirstName,
    this.customerLastName,
    this.customerEmail,
    this.customerHash,
    this.isSeen,
    this.customerStatus,
    this.customerAddress,
  });

  int? customerId;
  String? customerFirstName;
  String? customerLastName;
  String? customerEmail;
  String? customerHash;
  String? isSeen;
  String? customerStatus;
  List<dynamic>? customerAddress;

  factory CustomerDetail.fromJson(Map<String, dynamic> json) => CustomerDetail(
    customerId: json["customer_id"],
    customerFirstName: json["customer_first_name"],
    customerLastName: json["customer_last_name"],
    customerEmail: json["customer_email"],
    customerHash: json["customer_hash"],
    isSeen: json["is_seen"],
    customerStatus: json["customer_status"],
    customerAddress: List<dynamic>.from(json["customer_address"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "customer_id": customerId,
    "customer_first_name": customerFirstName,
    "customer_last_name": customerLastName,
    "customer_email": customerEmail,
    "customer_hash": customerHash,
    "is_seen": isSeen,
    "customer_status": customerStatus,
    "customer_address": List<dynamic>.from(customerAddress!.map((x) => x)),
  };
}

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
