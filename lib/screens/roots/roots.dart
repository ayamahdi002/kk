import 'package:HappyTaills/screens/roots/rout_name.dart';
import 'package:flutter/material.dart';

import 'SplachScreen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case RouteName.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(child: Text('No Route Defined For ${settings.name}')),
          );
        });
    }
  }
}
