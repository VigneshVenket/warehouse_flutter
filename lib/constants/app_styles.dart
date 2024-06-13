
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_kundol/constants/app_config.dart';

class AppStyles {

  static const Color COLOR_SEARCH_BAR = Color(0x77CDD2D3);

  static const Color COLOR_LIGHT_GREY = Color(0x77CDD2D3);

  static const Color COLOR_ICONS_DARK = Color(0xFFCCCCCC);
  static const Color COLOR_ICONS_LIGHT = Color(0xFF666666);

  static const Color COLOR_GREY_LIGHT = Color.fromRGBO(112,112,112,1);
  static const Color COLOR_GREY_DARK = Color.fromRGBO(160,160,160,1);

  static const Color COLOR_CARD_DARK = Color(0xFF555555);

  static const Color COLOR_LITE_GREY_LIGHT =  Color.fromRGBO(240, 240, 240, 1);
  static const Color COLOR_LITE_GREY_DARK = Color.fromRGBO(29, 29, 29, 1);

  static const double SCREEN_MARGIN_HORIZONTAL = 16.0;
  static const double SCREEN_MARGIN_VERTICAL = 12.0;
  static const double CARD_RADIUS = 10.0;
  static const double GRID_SPACING = 8.0;

  static const List<Color> cardColors = [
    Color(0xFFEAF3DE),
    Color(0xFFFBE5E2),
    Color(0xFFD7F2FE),
    Color(0xFFFFE9A5),
  ];

//  static const Color APP_BAR_COLOR_CHANGE = (AppConfig.APP_BAR_COLOR==1) ? Colors.blue : (AppConfig.APP_BAR_COLOR==2) ?Colors.white :Colors.black;
  static const Color APP_BACKGROUND_COLOR = (AppConfig.APP_DESIGN==1) ? Colors.white : (AppConfig.APP_DESIGN==2) ? Color(0x0478ed) :Colors.black;

}