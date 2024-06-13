class CountryData {
  int? countryId;
  String? countryName;
  List<States>? states;
  List<Cities>? cities;

  CountryData({this.countryId, this.countryName, this.states});

  CountryData.fromJson(Map<String, dynamic> json) {
    countryId = json['country_id'];
    countryName = json['country_name'];
    if (json['states'] != null) {
      states = <States>[];
      json['states'].forEach((v) {
        states?.add(States.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['country_id'] = countryId;
    data['country_name'] = countryName;
    if (states != null) {
      data['states'] = states?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class States {
  var id;
  String? name;
  var countryId;

  States({this.id, this.name, this.countryId});

  States.fromJson(Map<String, dynamic> json) {
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

class Cities {
  int? id;
  String? name;
  String? stateId;
  String? countryId;

  Cities({this.id, this.name, this.stateId, this.countryId,});

  Cities.fromJson(Map<String, dynamic> json) {
     id = json['id'];
     name = json['name'];
     stateId = json['state_id'];
     countryId = json['country_id'];
   }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['state_id'] = stateId;
    data['country_id'] = countryId;
    return data;
  }
}


// class CitiesData {
//   int? id;
//   String? name;
//   String? stateId;
//   String? countryId;
//
//   CitiesData({this.id, this.name, this.stateId, this.countryId,});
//
//    CitiesData.fromJson(Map<String, dynamic> json) {
//     id = json["id"];
//     name = json["name"];
//     stateId = json["state_id"];
//     countryId = json["country_id"];
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "state_id": stateId,
//     "country_id": countryId,
//   };
// }