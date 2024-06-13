class SettingsObj {
  String? settingKey;
  String? settingValue;
  String? settingType;

  SettingsObj({this.settingKey, this.settingValue, this.settingType});

  SettingsObj.fromJson(Map<String, dynamic> json) {
    settingKey = json['setting_key'];
    settingValue = json['setting_value'];
    settingType = json['setting_type'];
  }



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['setting_key'] = settingKey;
    data['setting_value'] = settingValue;
    data['setting_type'] = settingType;
    return data;
  }
}