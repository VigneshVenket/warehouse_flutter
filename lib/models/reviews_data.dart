class ReviewsData {
  int? id;
  Customer? customer;
  String? comment;
  String? rating;
  String? status;
  String? date;

  ReviewsData({this.id, this.customer, this.comment, this.rating, this.status,this.date});

  ReviewsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customer = json['customer'] != null
        ? Customer.fromJson(json['customer'])
        : null;
    comment = json['comment'];
    rating = json['rating'];
    status = json['status'];
    date=json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (customer != null) {
      data['customer'] = customer?.toJson();
    }
    data['comment'] = comment;
    data['rating'] = rating;
    data['status'] = status;
    return data;
  }
}

class Customer {
  int? customerId;
  String? customerFirstName;
  String? customerLastName;
  String? customerEmail;
  String? customerHash;
  String? isSeen;
  String? customerStatus;

  Customer(
      {this.customerId,
        this.customerFirstName,
        this.customerLastName,
        this.customerEmail,
        this.customerHash,
        this.isSeen,
        this.customerStatus});

  Customer.fromJson(Map<String, dynamic> json) {
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
