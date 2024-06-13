class PageData {
  int? id;
  String? slug;
  List<Detail>? detail;

  PageData({this.id, this.slug, this.detail});

  PageData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
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
    data['slug'] = slug;
    if (detail != null) {
      data['detail'] = detail?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Detail {
  String? title;
  String? description;
  Language? language;

  Detail({this.title, this.description, this.language});

  Detail.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    language = json['language'] != null
        ? Language.fromJson(json['language'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    if (language != null) {
      data['language'] = language?.toJson();
    }
    return data;
  }
}

class Language {
  int? id;
  String? languageName;
  String? code;
  int? isDefault;
  String? direction;
  String? directory;

  Language(
      {this.id,
        this.languageName,
        this.code,
        this.isDefault,
        this.direction,
        this.directory});

  Language.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    languageName = json['language_name'];
    code = json['code'];
    isDefault = json['is_default'];
    direction = json['direction'];
    directory = json['directory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['language_name'] = languageName;
    data['code'] = code;
    data['is_default'] = isDefault;
    data['direction'] = direction;
    data['directory'] = directory;
    return data;
  }
}