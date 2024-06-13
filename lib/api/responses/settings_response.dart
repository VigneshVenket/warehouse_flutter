import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/models/settings_obj.dart';

class SettingsResponse {

  static const String APP_NAME = "app_name";
  static const String CATEGORY_STYLE = "category_style";
  static const String HOME_STYLE = "home_style";
  static const String CARD_STYLE = "card_style";
  static const String BANNER_STYLE = "banner_style";
  static const String IOS_APP_URL = "ios_app_url";
  static const String GOOGLE_LOGIN = "google_login";
  static const String FACEBOOK_LOGIN = "facebook_login";
  static const String PHONE_LOGIN = "phone_login";
  static const String EMAIL_LOGIN = "email_login";
  static const String INVENTORY = "inventory";
  static const String LANGUAGE_ID = "language_id";
  static const String LANGUAGE_CODE = "language_code";
  static const String DIRECTION = "direction";
  static const String CURRENCY_ID = "currency_id";
  static const String CURRENCY_CODE = "currency_code";
  static const String CURRENCY_POS = "currency_pos";
  static const String CURRENCY_SYMBOL = "currency_symbol";
  static const String CURRENCY_DECIMALS = "currency_decimals";


  List<SettingsObj>? data;
  String? status;
  String? message;
  int? statusCode;

  SettingsResponse({this.data,this.status,  this.message, this.statusCode});

  SettingsResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(SettingsObj.fromJson(v));
      });
    }
    status = json['status'];
    message = json['message'];
    statusCode = json['status_code'];
  }

  SettingsResponse.withError(String? error){
    data = null;
    status = AppConstants.STATUS_ERROR;
    message = error;
    statusCode = 0;
  }

  String getKeyValue(String? key){
    for (int i=0; i<data!.length; i++){
      if (key == data?[i].settingKey) {
        return data![i].settingValue.toString();
      }
    }
    return "";
  }

  setKeyValue(String? key, String? value){
    for (int i=0; i<data!.length; i++){
      if (key == data?[i].settingKey) {
        data?[i].settingValue = value;
      }
    }
    return "";
  }



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    data['message'] = message;
    data['status_code'] = statusCode;
    return data;
  }
}
