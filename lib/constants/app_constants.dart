import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppConstants {
  static const STATUS_SUCCESS = "Success";
  static const STATUS_ERROR = "Error";

  static const PRODUCT_TYPE_SIMPLE = "simple";
  static const PRODUCT_TYPE_VARIABLE = "variable";

  static const COUPON_TYPE_FIXED = "fixed";
  static const COUPON_TYPE_PERCENTAGE = "percentage";

  static const BANNER_NAVIGATION_TYPE_CATEGORY = "Category";
  static const BANNER_NAVIGATION_TYPE_PRODUCT = "Product";


  static void showMessage(BuildContext context, String message,Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message, style: GoogleFonts.gothicA1(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.white
      )),
          backgroundColor: color
      ),
    );
  }
}


