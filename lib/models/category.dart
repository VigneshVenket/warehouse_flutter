import 'package:flutter/cupertino.dart';

class Category {
  int? id;
  String? name;
  String? desc;
  String? icon;
  String? gallary;
  var parent;

  Category({required this.id,required this.name,required this.desc,required this.icon,required this.gallary,required this.parent});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    desc = json['desc'];
    icon = json['icon'];
    gallary = json['gallary'];
    parent = json['parent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['desc'] = desc;
    data['icon'] = icon;
    data['gallary'] = gallary;
    data['parent'] = parent;
    return data;
  }
}