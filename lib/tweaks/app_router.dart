import 'package:flutter/material.dart';
import 'package:flutter_kundol/ui/fragments/home_fragment_2.dart';

class AppRouter {
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/replaced':
        return MaterialPageRoute(
          builder: (_) => HomeFragment2(),
        );
      case '/newscreen':
        return MaterialPageRoute(
          builder: (_) => HomeFragment2(),
        );
      default:
        return null!;
    }
  }
}
