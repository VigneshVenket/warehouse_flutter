class FiltersData {
  int? attributeId;
  List<Detail>? detail;
  List<Variations>? variations;

  FiltersData({this.attributeId, this.detail, this.variations});

  FiltersData.fromJson(Map<String, dynamic> json) {
    attributeId = json['attribute_id'];
    if (json['detail'] != null) {
      detail = <Detail>[];
      json['detail'].forEach((v) {
        detail?.add(Detail.fromJson(v));
      });
    }
    if (json['variations'] != null) {
      variations = <Variations>[];
      json['variations'].forEach((v) {
        variations?.add(Variations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['attribute_id'] = attributeId;
    if (detail != null) {
      data['detail'] = detail?.map((v) => v.toJson()).toList();
    }
    if (variations != null) {
      data['variations'] = variations?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Detail {
  String? name;

  Detail({this.name});

  Detail.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}

class Variations {
  int? id;
  List<Detail>? detail;

  Variations({this.id, this.detail});

  Variations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['detail'] != null) {
      detail = <Detail>[];
      json['detail'].forEach((v) {
        detail?.add(Detail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (detail != null) {
      data['detail'] = detail?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
