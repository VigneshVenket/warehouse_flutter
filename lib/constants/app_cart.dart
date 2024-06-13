
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppBadge{
  static final AppBadge _singleton = AppBadge._internal();

  factory AppBadge() {
    return _singleton;
  }

  AppBadge._internal();

   int cartTotalitems = 0;

   ValueNotifier<int> cartTotalitemsListener = ValueNotifier<int>(0);

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    cartTotalitems = prefs.getInt('cartTotalitems') ?? 0;
    cartTotalitemsListener.value = cartTotalitems;
  }

   void BadgeUpdate(int value) async{

    if(value==null) value=0;

    // Subtract the previous cartTotalitems value before updating
    cartTotalitemsListener.value -= cartTotalitems;

    // Update the cartTotalitems value with the new count
    cartTotalitems = value;

    // Update the cartTotalitemsListener with the new count
    cartTotalitemsListener.value += value;

    // Save the new count to shared preferences
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('cartTotalitems', value);

  }
   assignListner(ValueNotifier<int> updateBg){
     cartTotalitemsListener= updateBg;
     print("-------------------------------- assignListner ----------------------- ");
 }

   int getBadgeUpdate(){
     cartTotalitemsListener.value;
      return cartTotalitems;
  }
}